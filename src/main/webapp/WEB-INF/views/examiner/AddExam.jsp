<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<style>
  .page-wrapper {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    padding: 20px;
  }

  .form-container {
    width: 600px;
    margin: auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
  }

  .form-container h2 {
    text-align: center;
    margin-bottom: 24px;
    color: #343a40;
  }

  .form-container label {
    font-weight: bold;
    display: block;
    margin-top: 14px;
    margin-bottom: 5px;
    font-size: 14px;
    color: #343a40;
  }

  .form-container input,
  .form-container select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    font-size: 14px;
    box-sizing: border-box;
  }

  .form-container input:focus,
  .form-container select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0,123,255,0.15);
  }

  .btn-submit {
    margin-top: 24px;
    width: 100%;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
  }

  .btn-submit:hover {
    background: #0056b3;
  }

  .btn-cancel {
    display: block;
    text-align: center;
    margin-top: 10px;
    padding: 10px;
    background: #6c757d;
    color: white;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
  }

  .btn-cancel:hover {
    background: #545b62;
    color: white;
    text-decoration: none;
  }

  .alert-error {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
    border-radius: 6px;
    padding: 10px 14px;
    margin-bottom: 16px;
    font-size: 14px;
  }
</style>

<div class="page-wrapper">
  <div class="form-container">
    <h2>Create New Exam</h2>

    <c:if test="${not empty error}">
      <div class="alert-error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/examiner/saveExam" method="post">

      <label>Exam Title</label>
      <input type="text" name="examTitle" required
             placeholder="Enter exam title">

      <label>Subject</label>
      <select name="subjectId" required>
        <option value="">-- Select Subject --</option>
        <c:forEach items="${subjects}" var="s">
          <option value="${s.subjectId}">${s.subjectName}</option>
        </c:forEach>
      </select>

      <label>Difficulty</label>
      <select name="difficultyId" required>
        <option value="">-- Select Difficulty --</option>
        <%-- FIXED: was d.levelName → DifficultyLevelEntity has .level (enum) --%>
        <c:forEach items="${difficulties}" var="d">
          <option value="${d.difficultyId}">${d.level}</option>
        </c:forEach>
      </select>

      <label>Duration (Minutes)</label>
      <input type="number" name="duration" required
             min="1" placeholder="e.g. 60">

      <label>Total Marks</label>
      <input type="number" name="totalMarks" required
             min="1" placeholder="e.g. 100">

      <label>Status</label>
      <select name="status" required>
        <option value="ACTIVE">Active</option>
        <option value="INACTIVE">Inactive</option>
      </select>

      <button type="submit" class="btn-submit">Save Exam</button>
      <a href="${pageContext.request.contextPath}/examiner/myExams"
         class="btn-cancel">Cancel</a>

    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>