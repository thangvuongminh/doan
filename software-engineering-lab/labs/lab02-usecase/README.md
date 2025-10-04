Mô tả 2 chức năng quan trọng
# Use Case Descriptions - Mini App Hỗ Trợ Học Tập & Thi Trực Tuyến

## Use Case 1: Tham gia thi trắc nghiệm

### Thông tin cơ bản
- **Use Case ID:** UC-001
- **Use Case Name:** Tham gia thi trắc nghiệm
- **Primary Actor:** Học sinh
- **Secondary Actor:** Hệ thống
- **Brief Description:** Học sinh tham gia làm bài kiểm tra trắc nghiệm trực tuyến trên Zalo Mini App

### Preconditions (Điều kiện tiên quyết)
- Học sinh đã đăng nhập thành công vào hệ thống
- Có ít nhất một bài thi trắc nghiệm được tạo sẵn
- Bài thi đang trong thời gian cho phép làm bài
- Thiết bị có kết nối internet ổn định

### Postconditions (Điều kiện sau khi thực hiện)
- Bài thi được nộp thành công
- Điểm số được tính toán và lưu vào hệ thống
- Kết quả được hiển thị cho học sinh (nếu cấu hình cho phép)
- Thống kê được cập nhật

### Main Success Scenario (Luồng chính)
1. Học sinh mở Zalo Mini App "Hỗ Trợ Học Tập & Thi Trực Tuyến"
2. Hệ thống hiển thị danh sách các bài thi có thể tham gia
3. Học sinh chọn một bài thi trắc nghiệm
4. Hệ thống hiển thị thông tin bài thi (thời gian, số câu hỏi, điểm tối đa)
5. Học sinh xác nhận tham gia bài thi
6. Hệ thống bắt đầu bài thi và hiển thị câu hỏi đầu tiên
7. **REPEAT** cho mỗi câu hỏi:
   - Hệ thống hiển thị câu hỏi với các lựa chọn
   - Học sinh chọn đáp án
   - Học sinh chuyển sang câu tiếp theo hoặc quay lại câu trước
8. Học sinh hoàn thành tất cả câu hỏi
9. Hệ thống hiển thị trang xem lại bài làm
10. Học sinh xác nhận nộp bài
11. Hệ thống tính điểm tự động
12. Hệ thống hiển thị kết quả cho học sinh
13. Hệ thống lưu kết quả vào database

### Alternative Flows (Luồng thay thế)

#### A1: Hết thời gian làm bài
- **Trigger:** Thời gian làm bài kết thúc
- **Alternative:** 
  - 10a. Hệ thống tự động nộp bài
  - 10b. Chuyển đến bước 11 (tính điểm)

#### A2: Mất kết nối internet
- **Trigger:** Kết nối internet bị gián đoạn
- **Alternative:**
  - 7a. Hệ thống lưu tạm đáp án đã chọn
  - 7b. Hiển thị thông báo mất kết nối
  - 7c. Khi có kết nối lại, tiếp tục từ vị trí đã lưu

#### A3: Học sinh thoát giữa chừng
- **Trigger:** Học sinh đóng ứng dụng hoặc thoát khỏi bài thi
- **Alternative:**
  - 7a. Hệ thống lưu tiến độ hiện tại
  - 7b. Cho phép học sinh tiếp tục bài thi nếu còn thời gian

### Special Requirements (Yêu cầu đặc biệt)
- Thời gian phản hồi tối đa 3 giây cho mỗi thao tác
- Giao diện tương thích với màn hình điện thoại
- Hỗ trợ hiển thị hình ảnh trong câu hỏi
- Tự động lưu đáp án mỗi 30 giây

### Technology and Data Variations (Biến thể công nghệ và dữ liệu)
- Sử dụng Zalo Mini App Framework
- Dữ liệu được lưu trên Firebase Realtime Database
- API backend được xây dựng bằng NodeJS

---

## Use Case 2: Tạo đề thi

### Thông tin cơ bản
- **Use Case ID:** UC-002
- **Use Case Name:** Tạo đề thi
- **Primary Actor:** Giáo viên
- **Secondary Actor:** Hệ thống
- **Brief Description:** Giáo viên tạo và cấu hình đề thi trắc nghiệm hoặc tự luận

### Preconditions (Điều kiện tiên quyết)
- Giáo viên đã đăng nhập thành công với quyền giáo viên
- Có ngân hàng câu hỏi sẵn có (hoặc giáo viên sẽ tạo mới)

### Postconditions (Điều kiện sau khi thực hiện)
- Đề thi được tạo và lưu thành công
- Đề thi có thể được gán cho các lớp học cụ thể
- Học sinh có thể truy cập và làm bài thi

### Main Success Scenario (Luồng chính)
1. Giáo viên đăng nhập vào hệ thống
2. Giáo viên chọn chức năng "Tạo đề thi mới"
3. Hệ thống hiển thị form tạo đề thi
4. Giáo viên nhập thông tin cơ bản:
   - Tên đề thi
   - Môn học
   - Loại bài thi (trắc nghiệm/tự luận/hỗn hợp)
   - Thời gian làm bài
   - Điểm tối đa
   - Ngày giờ bắt đầu và kết thúc
5. Giáo viên chọn cách tạo câu hỏi:
   - Tạo câu hỏi mới
   - Chọn từ ngân hàng câu hỏi có sẵn
   - Nhập từ file Excel
6. **IF** tạo câu hỏi mới:
   - 6a. Giáo viên nhấn "Thêm câu hỏi"
   - 6b. **FOR** mỗi câu hỏi:
     - Nhập nội dung câu hỏi
     - Thêm hình ảnh (nếu có)
     - Nhập các lựa chọn (đối với trắc nghiệm)
     - Chọn đáp án đúng
     - Thiết lập điểm số cho câu hỏi
7. **ELSE IF** chọn từ ngân hàng:
   - 7a. Hệ thống hiển thị danh sách câu hỏi có sẵn
   - 7b. Giáo viên tích chọn các câu hỏi mong muốn
   - 7c. Hệ thống thêm câu hỏi vào đề thi
8. Giáo viên cấu hình thêm:
   - Trộn thứ tự câu hỏi
   - Hiển thị kết quả ngay sau khi nộp bài
   - Cho phép xem lại bài làm
   - Số lần làm bài tối đa
9. Giáo viên xem trước đề thi
10. Giáo viên lưu đề thi
11. Hệ thống validate thông tin đề thi
12. **IF** hợp lệ:
    - 12a. Lưu đề thi vào database
    - 12b. Hiển thị thông báo tạo thành công
    - 12c. Chuyển đến trang quản lý đề thi
13. **ELSE:**
    - 13a. Hiển thị thông báo lỗi
    - 13b. Quay lại form chỉnh sửa

### Alternative Flows (Luồng thay thế)

#### A1: Import từ file Excel
- **Trigger:** Giáo viên chọn import từ file
- **Alternative:**
  - 6a. Giáo viên chọn file Excel từ thiết bị
  - 6b. Hệ thống đọc và phân tích file
  - 6c. Hiển thị preview câu hỏi được import
  - 6d. Giáo viên xác nhận hoặc chỉnh sửa
  - 6e. Tiếp tục bước 8

#### A2: Dữ liệu không hợp lệ
- **Trigger:** Thông tin đề thi thiếu hoặc sai
- **Alternative:**
  - 11a. Hệ thống highlight các trường lỗi
  - 11b. Hiển thị thông báo cụ thể
  - 11c. Giáo viên sửa lỗi
  - 11d. Quay lại bước 10

#### A3: Sao chép từ đề thi có sẵn
- **Trigger:** Giáo viên muốn tạo đề thi tương tự
- **Alternative:**
  - 2a. Giáo viên chọn "Sao chép đề thi"
  - 2b. Chọn đề thi gốc
  - 2c. Hệ thống tạo bản sao
  - 2d. Tiếp tục từ bước 4 để chỉnh sửa

### Special Requirements (Yêu cầu đặc biệt)
- Hỗ trợ nhiều định dạng câu hỏi (text, hình ảnh, video)
- Tự động lưu nháp mỗi 2 phút
- Validate độ khó và phân bố điểm
- Hỗ trợ import/export đề thi

### Technology and Data Variations (Biến thể công nghệ và dữ liệu)
- Rich text editor cho câu hỏi tự luận
- Upload hình ảnh lên Firebase Storage
- Sử dụng SheetJS để đọc file Excel
- Compression hình ảnh tự động
