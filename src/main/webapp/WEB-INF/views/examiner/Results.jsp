<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="${pageContext.request.contextPath}/examiner/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<h3 class="mb-3">My Exam Results</h3>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <div class="table-responsive">
      <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Exam Name</th>
            <th>Subject</th>
            <th>Student Name</th>
            <th>Email</th>
            <th>Score</th>
            <th>Percentage</th>
            <th>Result</th>
            <th>Status</th>
            <th>Completed On</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${results}" var="r" varStatus="i">
            <tr>
              <td>${i.count}</td>

              <%-- FIXED: was r.exam.examTitle → correct is r.exam.examName --%>
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

              <td>${r.student.firstName} ${r.student.lastName}</td>
              <td>${r.student.email}</td>
              <td>${r.totalScore}</td>
              <td>${r.percentage}%</td>

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

              <td>${r.endTime}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty results}">
            <tr>
              <td colspan="10" class="text-center text-muted py-3">
                No results found yet.
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>

















