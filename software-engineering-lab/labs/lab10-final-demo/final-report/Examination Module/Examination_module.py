import mysql.connector
import random

# ------------------------------
# Kết nối MySQL
# ------------------------------
def get_conn():
    return mysql.connector.connect(
        host="localhost",
        user="root",                   # user trong MySQL
        password="12345",              # mật khẩu của user
        database="learning2",          # tên database
        auth_plugin="mysql_native_password",
        charset="utf8mb4",
        collation="utf8mb4_unicode_ci",
        use_unicode=True
    )

# ------------------------------
# Kiểm tra sinh viên đã làm đề chưa
# ------------------------------
def has_attempted(user_id, exam_id):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        "SELECT COUNT(*) FROM userexams WHERE user_exam_user_id=%s AND user_exam_exam_id=%s",
        (user_id, exam_id)
    )
    attempted = cur.fetchone()[0] > 0
    conn.close()
    return attempted

# ------------------------------
# Lấy danh sách câu hỏi + đáp án
# ------------------------------
def get_questions(exam_id):
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("""
        SELECT q.question_id, q.question_text
        FROM examquestions eq
        JOIN questions q ON eq.exam_question_question_id = q.question_id
        WHERE eq.exam_question_exam_id=%s
    """, (exam_id,))
    questions = cur.fetchall()

    # Lấy đáp án cho từng câu hỏi
    for q in questions:
        cur.execute("""
            SELECT answer_id, answer_text, is_correct
            FROM answers
            WHERE answer_question_id=%s
        """, (q['question_id'],))
        q['answers'] = cur.fetchall()

    conn.close()
    return questions

# ------------------------------
# Sinh viên làm bài thi
# ------------------------------
def take_exam(user_id, exam_id):
    if has_attempted(user_id, exam_id):
        print("❌ Bạn đã làm đề này rồi, không thể làm lại.")
        return

    questions = get_questions(exam_id)
    if not questions:
        print("⚠️ Không tìm thấy câu hỏi nào trong đề thi.")
        return

    score = 0
    total = len(questions)
    exam_results = []

    for q in questions:
        print(f"\nCâu hỏi: {q['question_text']}")
        for idx, ans in enumerate(q['answers']):
            print(f"{idx+1}. {ans['answer_text']}")

        # Mô phỏng random chọn đáp án
        chosen = random.choice(q['answers'])
        print(f"👉 Trả lời: {chosen['answer_text']}")

        # Lưu kết quả từng câu
        exam_results.append((q['question_id'], chosen['answer_id']))

        if chosen['is_correct']:
            score += 1

    final_score = round(score / total * 10, 2)

    # ------------------------------
    # Lưu vào DB
    # ------------------------------
    try:
        conn = get_conn()
        cur = conn.cursor()

        # Lưu điểm tổng
        cur.execute("""
            INSERT INTO userexams(user_exam_user_id, user_exam_exam_id, user_exam_score)
            VALUES (%s, %s, %s)
        """, (user_id, exam_id, final_score))
        user_exam_id = cur.lastrowid

        # Lưu từng câu trả lời
        for q_id, ans_id in exam_results:
            cur.execute("""
                INSERT INTO examresults(exam_result_user_exam_id, exam_result_question_id, exam_result_selected_answer_id)
                VALUES (%s, %s, %s)
            """, (user_exam_id, q_id, ans_id))

        conn.commit()
        print(f"\n✅ Kết quả: {score}/{total} đúng → Điểm: {final_score}")

    except Exception as e:
        print("Lỗi khi lưu kết quả:", e)
        conn.rollback()
    finally:
        conn.close()

# ------------------------------
# Chạy thử
# ------------------------------
if __name__ == "__main__":
    user_id = 1   # ID sinh viên (trong bảng users)
    exam_id = 1   # ID đề thi (trong bảng exams)
    print("Bắt đầu làm bài thi {exam_id} cho user {user_id}...\n")
    take_exam(user_id, exam_id)
