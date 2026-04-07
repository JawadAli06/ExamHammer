<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <h3 class="mb-3">Add Question</h3>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/examiner/saveQuestion" method="post">

      <div class="mb-3">
        <label class="form-label fw-bold">Exam</label>
        <select name="examId" class="form-select" required>
          <option value="">-- Select Exam --</option>
          <c:forEach var="e" items="${exams}">
            <option value="${e.examId}">
              ${e.examName}
              <c:if test="${not empty e.subject}"> — ${e.subject.subjectName}</c:if>
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Subject</label>
        <select name="subjectId" class="form-select" required>
          <option value="">-- Select Subject --</option>
          <c:forEach var="s" items="${subjects}">
            <option value="${s.subjectId}">${s.subjectName}</option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Difficulty</label>
        <select name="difficultyId" class="form-select" required>
          <option value="">-- Select Difficulty --</option>
          <c:forEach var="d" items="${difficulties}">
            <option value="${d.difficultyId}">${d.level}</option>
          </c:forEach>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Question Text</label>
        <textarea name="questionText" class="form-control" rows="4"
                  required placeholder="Enter question here..."></textarea>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Option A</label>
        <input type="text" name="optionA" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Option B</label>
        <input type="text" name="optionB" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Option C</label>
        <input type="text" name="optionC" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Option D</label>
        <input type="text" name="optionD" class="form-control" required>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Correct Option</label>
        <select name="correctOption" class="form-select" required>
          <option value="">-- Select Correct Option --</option>
          <option value="A">A</option>
          <option value="B">B</option>
          <option value="C">C</option>
          <option value="D">D</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold">Marks</label>
        <input type="number" name="marks" class="form-control"
               required min="1" placeholder="e.g. 2">
      </div>

      <button type="submit" class="btn btn-primary px-4">Save Question</button>
      <a href="${pageContext.request.contextPath}/examiner/questions"
         class="btn btn-secondary ms-2">Back</a>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>