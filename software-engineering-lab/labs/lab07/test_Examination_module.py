import unittest
from unittest.mock import patch, MagicMock
import Examination_module as exam_module


class TestExaminationModule(unittest.TestCase):

    # ------------------------------
    # Test has_attempted
    # ------------------------------
    @patch("Examination_module.get_conn")
    def test_has_attempted_true(self, mock_get_conn):
        mock_cursor = MagicMock()
        mock_cursor.fetchone.return_value = (1,)   # có 1 bản ghi

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_conn.return_value = mock_conn

        result = exam_module.has_attempted(1, 1)
        self.assertTrue(result)

    @patch("Examination_module.get_conn")
    def test_has_attempted_false(self, mock_get_conn):
        mock_cursor = MagicMock()
        mock_cursor.fetchone.return_value = (0,)   # không có bản ghi

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_conn.return_value = mock_conn

        result = exam_module.has_attempted(2, 1)
        self.assertFalse(result)

    # ------------------------------
    # Test get_questions
    # ------------------------------
    @patch("Examination_module.get_conn")
    def test_get_questions(self, mock_get_conn):
        mock_cursor = MagicMock()
        # Trả về 1 câu hỏi
        mock_cursor.fetchall.side_effect = [
            [{"question_id": 10, "question_text": "2+2=?"}],  # fetchall cho câu hỏi
            [   # fetchall cho đáp án
                {"answer_id": 1, "answer_text": "3", "is_correct": 0},
                {"answer_id": 2, "answer_text": "4", "is_correct": 1}
            ]
        ]

        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_conn.return_value = mock_conn

        result = exam_module.get_questions(1)
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]["question_id"], 10)
        self.assertEqual(len(result[0]["answers"]), 2)

    # ------------------------------
    # Test take_exam
    # ------------------------------
    @patch("Examination_module.get_conn")
    @patch("Examination_module.has_attempted")
    @patch("Examination_module.get_questions")
    def test_take_exam_already_attempted(self, mock_get_questions, mock_has_attempted, mock_get_conn):
        mock_has_attempted.return_value = True  # đã làm
        mock_get_questions.return_value = []

        result = exam_module.take_exam(1, 1)

        # Không có lưu DB
        mock_get_conn.assert_not_called()
        self.assertIsNone(result)

    @patch("Examination_module.get_conn")
    @patch("Examination_module.has_attempted")
    @patch("Examination_module.get_questions")
    @patch("Examination_module.random.choice")
    def test_take_exam_new_attempt(self, mock_choice, mock_get_questions, mock_has_attempted, mock_get_conn):
        mock_has_attempted.return_value = False
        mock_get_questions.return_value = [
            {
                "question_id": 10,
                "question_text": "2+2=?",
                "answers": [
                    {"answer_id": 1, "answer_text": "3", "is_correct": 0},
                    {"answer_id": 2, "answer_text": "4", "is_correct": 1}
                ]
            }
        ]

        # random.choice luôn chọn đáp án đúng
        mock_choice.return_value = {"answer_id": 2, "answer_text": "4", "is_correct": 1}

        mock_cursor = MagicMock()
        mock_conn = MagicMock()
        mock_conn.cursor.return_value = mock_cursor
        mock_get_conn.return_value = mock_conn

        exam_module.take_exam(1, 1)

        # Lấy tất cả lời gọi execute
        sql_calls = mock_cursor.execute.call_args_list

        # Kiểm tra có INSERT vào userexams
        found_userexams = any("INSERT INTO userexams" in call[0][0] for call in sql_calls)
        self.assertTrue(found_userexams)

        # Kiểm tra có tham số (1, 1, 10.0)
        found_params = any(call[0][1] == (1, 1, 10.0) for call in sql_calls if len(call[0]) > 1)
        self.assertTrue(found_params)

        # Commit được gọi
        mock_conn.commit.assert_called_once()


# ------------------------------
# ------------------------------
class VerboseTestResult(unittest.TextTestResult):
    def addSuccess(self, test):
        super().addSuccess(test)
        self.stream.writeln(f"✅ {test._testMethodName} PASSED")

    def addFailure(self, test, err):
        super().addFailure(test, err)
        self.stream.writeln(f"❌ {test._testMethodName} FAILED")

    def addError(self, test, err):
        super().addError(test, err)
        self.stream.writeln(f"⚠️ {test._testMethodName} ERROR")


if __name__ == "__main__":
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(TestExaminationModule)
    runner = unittest.TextTestRunner(resultclass=VerboseTestResult, verbosity=2)
    runner.run(suite)
