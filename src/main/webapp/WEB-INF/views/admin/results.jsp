<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<a href="${pageContext.request.contextPath}/admin/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<h3 class="mb-3">All Results</h3>

<div class="card shadow-sm border-0 rounded-4">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Student Name</th>
            <th>Exam Name</th>
            <th>Subject</th>
            <th>Examiner</th>
            <th>Score</th>
            <th>Percentage</th>
            <th>Result</th>
            <th>Status</th>
            <th>Submitted At</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${results}" var="r" varStatus="i">
            <tr>
              <td>${i.count}</td>

              <%-- FIXED: was r.student.firstName — correct --%>
              <td>${r.student.firstName} ${r.student.lastName}</td>

              <%-- FIXED: was r.exam.examName — correct --%>
              <td>${r.exam.examName}</td>

              <%-- Subject via exam --%>
              <td>
                <c:choose>
                  <c:when test="${not empty r.exam.subject}">
                    ${r.exam.subject.subjectName}
                  </c:when>
                  <c:otherwise>${r.exam.subjectName}</c:otherwise>
                </c:choose>
              </td>

              <%-- Examiner name — createdBy can be null for old exams --%>
              <td>
                <c:choose>
                  <c:when test="${not empty r.exam.createdBy}">
                    ${r.exam.createdBy.firstName} ${r.exam.createdBy.lastName}
                  </c:when>
                  <c:otherwise>
                    <span class="text-muted">—</span>
                  </c:otherwise>
                </c:choose>
              </td>

              <%-- FIXED: was r.score → correct field is r.totalScore --%>
              <td>${r.totalScore}</td>

              <%-- FIXED: was r.percentage — correct --%>
              <td>${r.percentage}%</td>

              <%-- FIXED: was missing — ExamAttemptEntity has result enum --%>
              <td>
                <c:choose>
                  <c:when test="${r.result == 'PASS'}">
                    <span class="badge bg-success">PASS</span>
                  </c:when>
                  <c:when test="${r.result == 'FAIL'}">
                    <span class="badge bg-danger">FAIL</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-secondary">—</span>
                  </c:otherwise>
                </c:choose>
              </td>

              <%-- Status --%>
              <td>
                <c:choose>
                  <c:when test="${r.status == 'COMPLETED'}">
                    <span class="badge bg-primary">Completed</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-warning text-dark">In Progress</span>
                  </c:otherwise>
                </c:choose>
              </td>

              <%-- FIXED: was r.attemptedAt → correct field is r.endTime --%>
              <td>${r.endTime}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty results}">
            <tr>
              <td colspan="10" class="text-center text-muted py-3">
                No results found.
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>