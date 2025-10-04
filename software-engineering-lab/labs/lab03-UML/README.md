File mô tả Sequence Diagram Lab 03 – Zalo Mini App     
Đối tượng tham gia (Actors & Components)   
- Student (Học sinh)  
Đăng nhập vào Zalo Mini App.   
Mở Mini App, duyệt danh sách bài thi và chọn bài.  
Nộp bài, xem điểm, xem giải thích đáp án và thứ hạng.    
Nhận nhắc lịch học/thi và thông báo kết quả.    
Tự động lưu tiến trình/đáp án (mỗi 30s) và có thể tiếp tục nếu mất kết nối.    
- Mini App UI (Zalo Mini App)
Hiển thị danh sách bài thi, thông tin bài, câu hỏi, trang xem lại, kết quả.   
Thực hiện OAuth với Zalo Platform.   
Gọi các endpoint: getExamList(), getExamDetail(examId), startExam(examId), submitAnswer(answer), autoSave(), submitExam(), getResult()...   
Quản lý lưu tạm client-side khi mất kết nối, hiển thị cảnh báo.   
- Backend API (NodeJS/Express)
Xử lý nghiệp vụ: cung cấp danh sách đề, chi tiết đề, phát tạo attempt, trả câu hỏi, nhận đáp án tạm thời, auto-save, tổng hợp & tính điểm, lưu kết quả cuối cùng, cập nhật leaderboard/statistics.   
Xử lý auto-submit khi hết thời gian (timer/server-side).   
Xử lý resume attempt khi học sinh kết nối lại.   
Giao tiếp với Firebase để đọc/ghi dữ liệu.   
- Firebase (Firestore / Storage)      
Lưu trữ: Users, Exams, Questions, Attempts (temp + final), Answers, Results, Leaderboards, file (images, excel).   
Cung cấp dữ liệu câu hỏi, lưu đáp án tạm thời, lưu kết quả cuối cùng, phục vụ thống kê.   
- Zalo Platform
Cung cấp OAuth để xác thực người dùng (access token).   
Môi trường chạy Mini App (UI trên Zalo).   
- Notification Service (Zalo OA / ZNS / Cloud Functions)   
Gửi thông báo nhắc lịch thi, nhắc chấm bài, gửi thông báo kết quả thi, thông báo auto-submit do hết giờ.   
- Thông điệp trao đổi (Messages)    
+ Use Case chính (theo Sequence Diagram của Student)   
- Đăng nhập Zalo OAuth:    
Student → Mini App UI → Zalo Platform (OAuth flow) → Zalo Platform → Mini App UI: trả access token → Mini App UI → Backend API: loginWithToken(token) → Backend API → Firebase: khởi tạo / cập nhật user (Users collection).   
- Lấy danh sách bài thi:   
Student → Mini App UI (mở app) → Mini App UI → Backend API: getExamList() → Backend API → Firebase: truy vấn Exams (SELECT exams đang hoạt động) → Firebase → Backend API: exam list → Backend API → Mini App UI: returnExamList() (UI hiển thị).     
- Xem chi tiết đề thi:
Student → Mini App UI (chọn bài) → Mini App UI → Backend API: getExamDetail(examId) → Backend API → Firebase: SELECT exam detail (thời gian, số câu, điểm tối đa, config) → Firebase → Backend API: exam detail → Backend API → Mini App UI: returnExamDetail().   
- Bắt đầu làm bài:   
Student → Mini App UI: xác nhận bắt đầu → Mini App UI → Backend API: startExam(examId) → Backend API → Firebase: tạo Attempt (ghi thời gian bắt đầu, studentId, examId, status="in_progress") → Backend API → Mini App UI: trả câu hỏi đầu tiên / token attempt.   
- Làm bài — vòng lặp câu hỏi + lưu tạm:   
Lặp cho mỗi câu:   
Mini App UI → Backend API: requestQuestion(questionId or next) → Backend API → Firebase: getQuestion(questionId) → Firebase → Backend API: question data → Backend API → Mini App UI: showQuestion() → Student → Mini App UI: chọn đáp án → Mini App UI → Backend API: submitAnswer(answer) → Backend API → Firebase: saveTempAnswer(attemptId, questionId, answer, timestamp).   
Auto-save (mỗi 30s): Mini App UI → Backend API: autoSave(attemptId) → Backend API → Firebase: update temp answers (đảm bảo persist).   
-Mất kết nối Internet (tạm thời):    
Khi mất: Mini App UI lưu local (localStorage/IndexedDB) và hiển thị thông báo cho Student.   
Khi kết nối lại: Mini App UI → Backend API: resumeAttempt(attemptId) → Backend API → Firebase: trả temp answers, time remaining → Mini App UI đồng bộ và tiếp tục từ vị trí đã lưu.   
- Hết thời gian làm bài (auto-submit):   
Trigger (server-side timer hoặc exam config): Backend API (timer/Cloud Function) → Backend API → Firebase: getAllAnswers(attemptId) → Backend API: calculateScore(attempt) → Backend API → Firebase: storeResult(attemptId, score, status="finished") → Backend API → Mini App UI: khi học sinh mở lại sẽ thấy kết quả → Backend API → Notification Service: gửi thông báo kết quả.   
- Học sinh nộp bài thủ công:   
Student → Mini App UI: nhấn "Nộp bài" → Mini App UI → Backend API: submitExam(attemptId) → Backend API → Firebase: getAllAnswers() → Backend API: calculateScore() → Backend API → Firebase: storeResult() & cập nhật leaderboard/statistics → Backend API → Mini App UI: showResult() → Backend API → Notification Service: gửi thông báo kết quả.   
- Xem kết quả & xếp hạng:   
Student → Mini App UI → Backend API: getResult(attemptId or examId) → Backend API → Firebase: lấy điểm, giải thích (per-question feedback nếu có), và leaderboard → Backend API → Mini App UI: hiển thị điểm, giải thích, thứ hạng.  
- Cập nhật thống kê (hậu xử lý):    
Sau khi lưu result: Backend API → Firebase: cập nhật aggregate stats (độ khó câu, distribution, average) và Backend API → Firebase: cập nhật Leaderboard/Rankings để Teacher/Student truy vấn.   
+ Nhắc lịch & Thông báo:   
Backend API / Cloud Functions → Notification Service → gửi nhắc lịch thi, thông báo auto-submit, thông báo kết quả → Notification Service → Student (via Zalo OA/ZNS)     
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Đối tượng tham gia (Actors & Components)       
- Teacher (Giáo viên)      
- Đăng nhập vào Zalo Mini App / Web Portal.       
Tạo đề thi mới, nhập thông tin cơ bản (tên đề, môn, loại, thời gian, điểm tối đa…).  
Thêm câu hỏi mới hoặc chọn từ ngân hàng, hoặc import từ file Excel.      
Cấu hình trộn câu, hiển thị kết quả, số lần làm bài.     
Lưu đề thi, xuất bản hoặc lên lịch thi.      
Nhận nhắc lịch chấm / lịch thi, xem thống kê độ khó và điểm số.      
- Mini App UI / Web Portal     
Hiển thị form tạo đề thi, ngân hàng câu hỏi, tính năng import file Excel.   
Gọi các API: getCreateExamForm(), submitExamInfo(), addQuestion(), uploadImage(), importFromExcel(), validateExam(), saveExam()…   
Tự động lưu nháp mỗi 2 phút.      
- Backend API (NodeJS/Express)    
Xử lý nghiệp vụ tạo đề thi, lưu nháp, thêm câu hỏi, import Excel, upload hình ảnh, validate cấu hình, lưu đề thi cuối cùng.     
Giao tiếp với Firebase để lưu trữ đề thi/câu hỏi/ngân hàng.   
Tạo bản sao đề thi (clone exam).   
- Firebase (Firestore / Storage)   
Lưu Users (role Teacher), Exams, Questions, BankQuestions, Imports.   
Lưu hình ảnh, file Excel, cấu hình đề thi.   
Trả dữ liệu cho API khi Teacher cần xem ngân hàng hoặc xem preview đề thi.   
- Zalo Platform   
Cung cấp OAuth để xác thực giáo viên.
Là môi trường chạy Mini App / Web Portal.   
- Notification Service (Zalo OA / Cloud Functions)   
Gửi nhắc nhở giáo viên về lịch chấm, lịch thi, hoặc trạng thái import/đề thi.   
Thông báo “Đề thi tạo thành công” hoặc lỗi import.   
- Thông điệp trao đổi (Messages)   
Use Case chính (theo Sequence Diagram của Teacher)    
- Đăng nhập Zalo OAuth:   
Teacher → Mini App UI → Zalo Platform (OAuth flow) → Zalo Platform → Mini App UI: trả access token → Mini App UI → Backend API: loginWithToken(token) → Backend API → Firebase: xác minh / khởi tạo user role=Teacher.    
- Mở form tạo đề thi:   
Teacher → Mini App UI: chọn “Tạo đề thi mới” → Mini App UI → Backend API: getCreateExamForm() → Backend API: trả form cấu hình đề thi → Mini App UI: hiển thị form.
- Nhập thông tin cơ bản đề thi:   
Teacher → Mini App UI: nhập tên đề thi, môn, loại, thời gian, điểm tối đa, thời gian bắt đầu/kết thúc → Mini App UI → Backend API: submitExamInfo(data) → Backend API → Firebase: saveDraftExam() (trạng thái draft).   
- Thêm câu hỏi mới:   
Teacher → Mini App UI: “Thêm câu hỏi” → Mini App UI → Backend API: addQuestion(questionData) → Backend API → Firebase: saveQuestion() (câu hỏi mới).   
Nếu có hình ảnh: Mini App UI → Backend API: uploadImage(file) → Backend API → Firebase Storage: storeImage().  
- Chọn câu hỏi từ ngân hàng:   
Teacher → Mini App UI: mở ngân hàng → Mini App UI → Backend API: getQuestionBank() → Backend API → Firebase: lấy danh sách câu hỏi → Backend API → Mini App UI: hiển thị → Teacher: tick chọn → Mini App UI → Backend API: addSelectedQuestions() → Backend API → Firebase: liên kết câu hỏi vào đề thi.   
- Import câu hỏi từ Excel (luồng tùy chọn):   
Teacher → Mini App UI: upload file Excel → Mini App UI → Backend API: importFromExcel(file) → Backend API: parse Excel → Backend API → Mini App UI: show preview câu hỏi → Teacher: xác nhận import → Mini App UI → Backend API: saveImportedQuestions() → Backend API → Firebase: lưu câu hỏi.   
- Cấu hình thêm đề thi:   
Teacher → Mini App UI: chọn các tùy chọn: trộn câu hỏi, hiển thị kết quả, số lần làm bài, quyền xem lại bài…   
UI auto-save nháp mỗi 2 phút: Mini App UI → Backend API: autoSaveExamDraft() → Backend API → Firebase: cập nhật draftExam.    
- Xem trước đề thi:   
Teacher → Mini App UI: “Xem trước” → Mini App UI → Backend API: previewExam(examId) → Backend API → Firebase: lấy thông tin → Backend API → Mini App UI: hiển thị preview.   
- Validate và lưu đề thi chính thức:   
Teacher → Mini App UI: nhấn “Lưu đề thi” → Mini App UI → Backend API: validateExam(examId) → Backend API → Firebase: check fields & cấu hình.   
Nếu hợp lệ: Backend API → Firebase: saveExam(status=active) → Backend API → Mini App UI: returnSuccess + redirect trang quản lý đề thi → Notification Service: gửi “Đề thi tạo thành công”.   
Nếu không hợp lệ: Backend API → Mini App UI: returnError + highlight field lỗi.   
- Clone đề thi có sẵn (luồng thay thế):   
Teacher → Mini App UI: chọn “Sao chép đề thi” → Mini App UI → Backend API: cloneExam(examId) → Backend API → Firebase: tạo bản sao → Backend API → Mini App UI: chuyển sang form chỉnh sửa.    
