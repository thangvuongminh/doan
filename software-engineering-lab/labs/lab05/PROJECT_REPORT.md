# 📘 Project Report – Mini App E-Learning  

---

## 1. Giới thiệu dự án 🚀  

- **Tên dự án**: Mini App E-Learning Hỗ Trợ Học Tập Trực Tuyến 🎓  
- **Mục tiêu**:  
  - Xây dựng một ứng dụng mini cho sinh viên học trực tuyến.  
  - Quản lý: môn học, chủ đề, tài liệu, bài tập, quiz, thi thử, thi chính thức.  
  - Hỗ trợ: chat 💬, forum 👥, tiến độ học 📊, phản hồi 🔔, điểm số ✅.  
- **Quy mô**: Bài tập học tập (lab) – triển khai cơ bản dựa trên database đã thiết kế.  

---

## 2. Artifacts đã xây dựng 🛠️  

### 2.1. Use Case 🎯  

| Actor | Chức năng |
|-------|-----------|
| Student 👩‍🎓 | Đăng nhập 🔑, tham gia khóa học 📚, xem tài liệu 📄, làm quiz/thi 📝, theo dõi tiến độ 📊, nhận huy hiệu 🏅 |
| Teacher 👨‍🏫 | Tạo chủ đề 🗂️, ra đề 📑, quản lý câu hỏi ❓, chấm điểm ✅, meeting 💻 |
| Admin 👨‍💼 | Quản lý user 👥, môn học 📖, gói subscription 💳, thống kê 📈 |
| System ⚙️ | Thông báo 🔔, leaderboard 🏆, nhắc deadline ⏰ |

---

### 2.2. Sequence Diagrams 🔁  

- **Luồng học Student**: Đăng nhập → Chọn khóa học → Xem tài liệu → Làm quiz → Nhận điểm  
- **Nộp bài tập**: Upload file → Backend lưu → Teacher chấm → Gửi phản hồi  
- **Thi chính thức**: Bắt đầu thi → Trả lời → Lưu kết quả → Tính điểm → Thông báo  
- **Thanh toán**: Chọn gói → Thanh toán → Backend cập nhật → Thông báo kích hoạt  
- **Job hệ thống**: Cron check deadline → Gửi nhắc nhở → Backup → Cập nhật leaderboard  

---

### 2.3. Database & ERD 🗄️  

- **Users** 👤: quản lý tài khoản (student, teacher, admin)  
- **Subjects – Topics – StudyMaterials** 📚: môn học, chủ đề, tài liệu  
- **Questions – Answers – QuestionTypes** ❓: ngân hàng câu hỏi  
- **Exams – ExamQuestions – UserExams – ExamResults** 📝: thi & kết quả  
- **PracticeTests – UserPractices – PracticeResults** 🧑‍🏫: thi thử  
- **ProgressTracker – StudySessions – Notes** 📊🗒️: tiến độ học  
- **Badges – Leaderboard – DailyChallenges** 🏅🔥: gamification  
- **ChatGroups – Forum – Meetings** 💬: giao tiếp  
- **Feedbacks – Announcements – Payments – Subscriptions** 📢💳: quản trị  

---

### 2.4. Form Login 🔑  

- **Frontend**: `index.html`, `styles.css`, `main.js`  
- **Backend**: API xác thực (Express + MySQL)  
- **Testing**: Unit test (login), Integration test (form login)  

---

## 3. Quy trình phát triển 📋  

1. **Phân tích yêu cầu**: Xác định actor + use case  
2. **Thiết kế hệ thống**: ERD, module chính  
3. **Lập trình & tích hợp**: API CRUD, login, exam flow  
4. **Quản lý source code**: Git/GitHub, tag phiên bản  
5. **Kiểm thử**: Unit test, integration test, manual test  
6. **Báo cáo**: Markdown + test case  

---

## 4. Git Workflow 🌐  

```bash
# Config lần đầu
git config --global user.name "Tên của bạn"
git config --global user.email "email@example.com"

# Thêm remote
git remote add origin https://github.com/thangvuongminh/doan.git

# Push code
git add .
git commit -m "E-Learning 1.0"
git push origin main

# Tạo tag
git tag v1.0
git push origin v1.0
