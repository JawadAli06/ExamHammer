<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<style>
  .page-wrapper {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    padding: 20px;
  }

  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .top-bar h2 {
    margin: 0;
    color: #343a40;
  }

  .btn-add {
    padding: 10px 16px;
    background: #28a745;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-size: 14px;
  }

  .btn-add:hover {
    background: #218838;
    color: white;
    text-decoration: none;
  }

  .exam-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    border-radius: 8px;
    overflow: hidden;
  }

  .exam-table th,
  .exam-table td {
    padding: 12px 14px;
    border: 1px solid #dee2e6;
    text-align: center;
    font-size: 14px;
  }

  .exam-table thead th {
    background: #007bff;
    color: white;
    font-weight: bold;
    border-color: #0069d9;
  }

  .exam-table tbody tr:hover {
    background: #f1f3f5;
  }

  .badge-active {
    background: #28a745;
    color: white;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
  }

  .badge-inactive {
    background: #6c757d;
    color: white;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
  }

  .no-data {
    margin-top: 20px;
    color: #666;
    font-size: 14px;
  }
</style>

<div class="page-wrapper">
<a href="${pageContext.request.contextPath}/examiner/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>
  <div class="top-bar">
  
    <h2>${not empty pageTitle ? pageTitle : 'Exams'}</h2>
    
    <a class="btn-add"
       href="${pageContext.request.contextPath}/examiner/addExam">
      + Add New Exam
      
    </a>
  </div>

  <c:if test="${empty exams}">
    <div class="no-data">No exams found.</div>
  </c:if>

  <c:if test="${not empty exams}">
    <table class="exam-table">
      <thead>
        <tr>
          <th>#</th>
          <th>Exam Name</th>
          <th>Subject</th>
          <th>Difficulty</th>
          <th>Duration (min)</th>
          <th>Total Marks</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${exams}" var="e" varStatus="i">
          <tr>
            <td>${i.count}</td>

            <%-- FIXED: was e.examTitle → correct field is e.examName --%>
            <td>${e.examName}</td>

            <%-- FIXED: subject is an object, not a string --%>
            <td>
              <c:choose>
                <c:when test="${not empty e.subject}">${e.subject.subjectName}</c:when>
                <c:otherwise>${e.subjectName}</c:otherwise>
              </c:choose>
            </td>

            <%-- FIXED: difficulty is an object, .level is the enum field --%>
            <td>${e.difficulty.level}</td>

            <%-- FIXED: was e.duration → correct field is e.durationMinutes --%>
            <td>${e.durationMinutes}</td>

            <td>${e.totalMarks}</td>

            <td>
              <c:choose>
                <c:when test="${e.status == 'ACTIVE'}">
                  <span class="badge-active">Active</span>
                </c:when>
                <c:otherwise>
                  <span class="badge-inactive">Inactive</span>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>