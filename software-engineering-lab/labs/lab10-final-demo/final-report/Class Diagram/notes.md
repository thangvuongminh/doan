## 1. Class Diagram
### 1.1 Danh sách Class
#### **User (Base Class)**
- **Attributes**
  - `userId: String`
  - `name: String`
  - `email: String`
  - `role: String (STUDENT | TEACHER | ADMIN)`
- **Methods**
  - `loginWithZalo(token: String): AuthResult`
  - `updateProfile(data: Map): void`
#### **Teacher (extends User)**
- **Attributes**
  - `teacherId: String` (alias `userId`)
  - `department: String`
- **Methods**
  - `createExam(examDTO): Exam`
  - `editExam(examId: String, examDTO): Exam`
  - `addQuestion(examId: String, questionDTO): Question`
  - `importFromExcel(examId: String, fileUrl: String): ImportResult`
  - `gradeEssay(attemptId: String, questionId: String, score: float, feedback: String): void`
  - `viewStatistics(examId: String): Statistics`

#### **Student (extends User)**
- **Attributes**
  - `studentId: String` (alias `userId`)
  - `classId: String` hoặc `classIds: List<String>`
- **Methods**
  - `viewExamList(filter: Map): List<Exam>`
  - `startExam(examId: String): Attempt`
  - `resumeExam(attemptId: String): Attempt`
  - `submitAnswer(attemptId: String, questionId: String, answer: AnswerPayload): void`
  - `submitExam(attemptId: String): Result`
  - `viewResult(attemptId: String): Result`
#### **Exam**
- **Attributes**
  - `examId: String`
  - `title: String`
  - `subject: String`
  - `type: String (MCQ | ESSAY | MIXED)`
  - `durationMinutes: int`
  - `startAt: DateTime`
  - `endAt: DateTime`
  - `status: String (DRAFT | PUBLISHED | CLOSED)`
  - `questionIds: List<String>`
  - `config: Map` (immediateResult, allowReview, maxAttempts, shuffleQuestions)
- **Methods**
  - `addQuestion(q: Question): void`
  - `validate(): ValidationResult`
  - `publish(): void`
  - `archive(): void`
#### **QuestionBank**
- **Attributes**
  - `bankId: String`
  - `ownerId: String`
  - `name: String`
  - `meta: Map`
- **Methods**
  - `search(criteria: Map): List<Question>`
  - `addQuestion(q: Question): Question`
  - `importQuestions(fileUrl: String): ImportResult`
#### **Question**
- **Attributes**
  - `questionId: String`
  - `examId: String` (nullable nếu thuộc QuestionBank)
  - `content: String` (text/HTML/Markdown)
  - `mediaUrl: List<String>`
  - `type: String (MCQ | ESSAY)`
  - `choices?: List<Choice>`
  - `weight: float`
  - `difficulty: String (EASY | MEDIUM | HARD)`
- **Methods**
  - `getChoices(): List<Choice>`
  - `isAutoMarkable(): boolean`
#### **Choice**
- **Attributes**
  - `choiceId: String`
  - `questionId: String`
  - `text: String`
  - `isCorrect: boolean`
- **Methods**
  - (Value object – không có method phức tạp)
#### **Attempt**
- **Attributes**
  - `attemptId: String`
  - `examId: String`
  - `studentId: String`
  - `startedAt: DateTime`
  - `lastSavedAt: DateTime`
  - `finishedAt?: DateTime`
  - `status: String (IN_PROGRESS | PAUSED | SUBMITTED | AUTO_SUBMITTED)`
  - `score?: float`
  - `timeRemainingSeconds?: int`
- **Methods**
  - `saveTempAnswer(questionId: String, answerPayload: AnswerPayload): void`
  - `autoSave(): void`
  - `finalizeAndScore(): Result`
  - `resume(): Attempt`
#### **Answer**
- **Attributes**
  - `answerId: String`
  - `attemptId: String`
  - `questionId: String`
  - `response: String | List<String>`
  - `updatedAt: DateTime`
  - `isAutoMarked: boolean`
  - `autoMarkScore?: float`
  - `manualScore?: float`
  - `feedback?: String`
- **Methods**
  - `markAuto(correct: boolean): float`
  - `applyManualScore(score: float, feedback: String): void`
#### **Result**
- **Attributes**
  - `resultId: String`
  - `attemptId: String`
  - `totalScore: float`
  - `rank?: int`
  - `generatedAt: DateTime`
  - `breakdown?: Map<questionId, score>`
- **Methods**
  - `computeRank(context): int`
  - `publish(): void`
#### **Notification**
- **Attributes**
  - `notificationId: String`
  - `userId: String`
  - `type: String (REMINDER | RESULT | SCHEDULE | SYSTEM)`
  - `content: String`
  - `status: String (PENDING | SENT | FAILED)`
  - `sentAt: DateTime`
- **Methods**
  - `send(): void`
---
## 1.2 Relationships 
- **User – Notification**:  
  - Quan hệ **1..*** (một User có thể nhận nhiều Notification).  
  - Notification **belongs to** User qua `userId`.
- **User (Base) – Teacher / Student**:  
  - `Teacher` **kế thừa (extends)** `User`.  
  - `Student` **kế thừa (extends)** `User`.
- **Teacher – Exam**:  
  - Quan hệ **1..*** (một Teacher có thể tạo nhiều Exam).  
  - `Teacher` **owns** `Exam` qua `createdBy` hoặc `teacherId`.
- **Exam – Question**:  
  - Quan hệ **1..*** (một Exam chứa nhiều Question).  
  - `Question.examId` tham chiếu tới `Exam.examId`.
- **QuestionBank – Question**:  
  - Quan hệ **1..*** (một QuestionBank chứa nhiều Question).  
  - `Question.examId` có thể nullable nếu thuộc QuestionBank.
- **Question – Choice**:  
  - Quan hệ **1..*** (một Question có nhiều Choice khi là MCQ).  
  - `Choice.questionId` tham chiếu tới `Question.questionId`.
- **Student – Attempt**:  
  - Quan hệ **1..*** (một Student có thể làm nhiều Attempt cho các Exam).  
  - `Attempt.studentId` tham chiếu `Student.userId`.
- **Attempt – Exam**:  
  - Quan hệ **n..1** (nhiều Attempt thuộc một Exam).  
  - `Attempt.examId` tham chiếu `Exam.examId`.
- **Attempt – Answer**:  
  - Quan hệ **1..*** (một Attempt có nhiều Answer).  
  - `Answer.attemptId` tham chiếu `Attempt.attemptId`.
- **Answer – Question**:  
  - Quan hệ **n..1** (mỗi Answer thuộc về một Question cụ thể).  
  - `Answer.questionId` tham chiếu `Question.questionId`.
- **Attempt – Result**:  
  - Quan hệ **1..1** (mỗi Attempt sinh ra một Result).  
  - `Result.attemptId` tham chiếu `Attempt.attemptId`.
- **Teacher – Answer** (essay grading):  
  - Quan hệ gián tiếp: `Teacher` có thể chấm `Answer` của `Attempt` khi loại câu hỏi là tự luận.  
---
# 2. Package Diagram

## 2.1 Danh sách Package & Components

### UI Layer (Zalo Mini App / Web Portal)
**Components**
- StudentUI  
- TeacherUI  
- AuthUI  

**Nhiệm vụ**
- Hiển thị giao diện cho học sinh và giáo viên.  
- Gửi yêu cầu đến Backend API (Exam, Attempt, Result, Statistics, …).  

---

### API Layer (NodeJS / Express Services)
**Components**
- AuthService  
- ExamService  
- QuestionService  
- AttemptService  
- ResultService  
- StatisticsService  

**Nhiệm vụ**
- Xử lý toàn bộ nghiệp vụ chính.  
- Là cầu nối giữa UI Layer và Data Layer.  
- Tích hợp với Notification Layer để gửi nhắc nhở và kết quả.  

---

### Data Layer (Firestore / Storage)
**Collections**
- UsersCollection  
- ExamsCollection  
- QuestionsCollection  
- AttemptsCollection  
- ResultsCollection  
- Leaderboards  

**Nhiệm vụ**
- Lưu trữ dữ liệu người dùng, đề thi, câu hỏi, kết quả, bảng xếp hạng.  

---

### Notification Layer
**Components**
- ReminderService  
- ResultNotification  

**Nhiệm vụ**
- Gửi nhắc nhở làm bài thi.  
- Gửi thông báo kết quả cho học sinh.  

---

## 2.2 Relationships

- **UI Layer → API Layer**
  - StudentUI gọi: ExamService, AttemptService, ResultService.  
  - TeacherUI gọi: ExamService, QuestionService, StatisticsService.  
  - AuthUI gọi: AuthService.  
  - → Quan hệ *phụ thuộc / uses*: UI phụ thuộc vào API để lấy và gửi dữ liệu.  

- **API Layer → Data Layer**
  - AuthService ↔ UsersCollection  
  - ExamService ↔ ExamsCollection, QuestionsCollection  
  - AttemptService ↔ AttemptsCollection  
  - ResultService ↔ ResultsCollection  
  - StatisticsService ↔ Leaderboards  
  - → Quan hệ *phụ thuộc / uses*: API phụ thuộc vào Data Layer để lưu/đọc dữ liệu.  

- **API Layer → Notification Layer**
  - ExamService ↔ ReminderService  
  - ResultService ↔ ResultNotification  
  - → Quan hệ *phụ thuộc / uses*: API gọi Notification để gửi thông báo.  
