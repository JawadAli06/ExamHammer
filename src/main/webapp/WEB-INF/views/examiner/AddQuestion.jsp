<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <h3 class="mb-3">Add Question</h3>

    <form action="${pageContext.request.contextPath}/examiner/saveQuestion" method="post">

      <div class="mb-3">
        <label class="form-label">Exam</label>
       <select name="examId" class="form-control" required>
    <option value="">Select Exam</option>
    <c:forEach var="e" items="${exams}">
        <option value="${e.examId}" ${selectedExamId == e.examId ? 'selected' : ''}>
            ${e.examName}
        </option>
    </c:forEach>
</select>
}
      </div>

    <!--   <div class="mb-3">
        <label class="form-label">Subject</label>
        <select name="subjectId" class="form-control" required>
          <option value="">Select Subject</option>
          <c:forEach var="s" items="${subjects}">
            <option value="${s.subjectId}">${s.subjectName}</option>
          </c:forEach>
        </select>
      </div>--> 

      <div class="mb-3">
    <label>Question</label>
    <textarea name="questionText" class="form-control" required></textarea>
</div>

<div class="mb-3">
    <label>Option A</label>
    <input type="text" name="optionA" class="form-control" required>
</div>

<div class="mb-3">
    <label>Option B</label>
    <input type="text" name="optionB" class="form-control" required>
</div>

<div class="mb-3">
    <label>Option C</label>
    <input type="text" name="optionC" class="form-control" required>
</div>

<div class="mb-3">
    <label>Option D</label>
    <input type="text" name="optionD" class="form-control" required>
</div>

<div class="mb-3">
    <label>Correct Answer</label>
    <select name="correctAnswer" class="form-control">
        <option value="A">Option A</option>
        <option value="B">Option B</option>
        <option value="C">Option C</option>
        <option value="D">Option D</option>
    </select>
</div>

<div class="mb-3">
    <label>Marks</label>
    <input type="number" name="marks" class="form-control" required>
</div>

      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-primary">Save</button>
        <a href="${pageContext.request.contextPath}/examiner/questions" class="btn btn-secondary">Back</a>
      </div>

    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>
