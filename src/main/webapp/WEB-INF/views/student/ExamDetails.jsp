<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <h3 class="mb-3">Exam Details</h3>

    <table class="table table-bordered">
      <tr>
        <th>Exam Name</th>
        <td>${exam.examName}</td>
      </tr>
      <tr>
        <th>Exam Type</th>
        <td>${exam.examType}</td>
      </tr>
      <tr>
        <th>Subject</th>
        <td>${exam.subjectName}</td>
      </tr>
      <tr>
        <th>Difficulty</th>
        <td>${exam.difficulty.level}</td>
      </tr>
      <tr>
        <th>Passing Score</th>
        <td>${exam.passingScore}</td>
      </tr>
      <tr>
        <th>Negative Marking</th>
        <td>${exam.negativeMarking}</td>
      </tr>
      <tr>
        <th>Start Date</th>
        <td>${exam.startDate}</td>
      </tr>
      <tr>
        <th>End Date</th>
        <td>${exam.endDate}</td>
      </tr>
      <tr>
        <th>Status</th>
        <td>${exam.status}</td>
      </tr>
    </table>

    <div class="d-flex gap-2">
      <a href="${pageContext.request.contextPath}/student/startExam/${exam.examId}" class="btn btn-success">
        Start Exam
      </a>
      <a href="${pageContext.request.contextPath}/student/exams" class="btn btn-secondary">
        Back
      </a>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>