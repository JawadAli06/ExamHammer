<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <h3 class="mb-3">Edit Question</h3>

    <form action="${pageContext.request.contextPath}/examiner/questions/update" method="post">
      <input type="hidden" name="questionId" value="${question.questionId}">

      <div class="mb-3">
        <label class="form-label">Exam</label>
        <select name="examId" class="form-control" required>
          <c:forEach var="e" items="${exams}">
            <option value="${e.examId}" ${question.exam.examId == e.examId ? 'selected' : ''}>
              ${e.examName}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Subject</label>
        <select name="subjectId" class="form-control" required>
          <c:forEach var="s" items="${subjects}">
            <option value="${s.subjectId}" ${question.subject.subjectId == s.subjectId ? 'selected' : ''}>
              ${s.subjectName}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Question Text</label>
        <textarea name="questionText" class="form-control" rows="4" required>${question.questionText}</textarea>
      </div>

      <div class="mb-3">
        <label class="form-label">Option A</label>
        <input type="text" name="optionA" class="form-control" value="${question.optionA}" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Option B</label>
        <input type="text" name="optionB" class="form-control" value="${question.optionB}" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Option C</label>
        <input type="text" name="optionC" class="form-control" value="${question.optionC}" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Option D</label>
        <input type="text" name="optionD" class="form-control" value="${question.optionD}" required>
      </div>

      <div class="mb-3">
        <label class="form-label">Correct Answer</label>
        <select name="correctAnswer" class="form-control" required>
          <option value="A" ${question.correctAnswer == 'A' ? 'selected' : ''}>Option A</option>
          <option value="B" ${question.correctAnswer == 'B' ? 'selected' : ''}>Option B</option>
          <option value="C" ${question.correctAnswer == 'C' ? 'selected' : ''}>Option C</option>
          <option value="D" ${question.correctAnswer == 'D' ? 'selected' : ''}>Option D</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">Marks</label>
        <input type="number" name="marks" class="form-control" value="${question.marks}" required>
      </div>

      <button class="btn btn-primary">Update</button>
      <a href="${pageContext.request.contextPath}/examiner/questions" class="btn btn-secondary">Back</a>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>