<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<a href="${pageContext.request.contextPath}/student/dashboard"
   class="btn btn-outline-secondary btn-sm mb-3">
  <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
</a>

<h3 class="mb-3">Exam Result</h3>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body p-4">

    <h4 class="fw-bold mb-1">${exam.examName}</h4>
    <p class="text-muted mb-3">
      <c:choose>
        <c:when test="${not empty exam.subject}">${exam.subject.subjectName}</c:when>
        <c:otherwise>${exam.subjectName}</c:otherwise>
      </c:choose>
      &nbsp;|&nbsp; ${exam.difficulty.level}
    </p>

    <hr>

    <div class="row g-3 mb-3">

      <div class="col-6 col-md-3">
        <div class="p-3 rounded-3 text-center" style="background:#e8f1ff;">
          <div style="font-size:28px;font-weight:700;color:#0d6efd;">
            ${totalQuestions}
          </div>
          <div style="font-size:12px;color:#6c757d;">Total Questions</div>
        </div>
      </div>

      <div class="col-6 col-md-3">
        <div class="p-3 rounded-3 text-center" style="background:#e9fbf2;">
          <%-- FIXED: was correctCount → correct is correctAnswers --%>
          <div style="font-size:28px;font-weight:700;color:#198754;">
            ${correctAnswers}
          </div>
          <div style="font-size:12px;color:#6c757d;">Correct</div>
        </div>
      </div>

      <div class="col-6 col-md-3">
        <div class="p-3 rounded-3 text-center" style="background:#ffecec;">
          <div style="font-size:28px;font-weight:700;color:#dc3545;">
            ${wrongAnswers}
          </div>
          <div style="font-size:12px;color:#6c757d;">Wrong</div>
        </div>
      </div>

      <div class="col-6 col-md-3">
        <div class="p-3 rounded-3 text-center" style="background:#fff6e8;">
          <div style="font-size:28px;font-weight:700;color:#fd7e14;">
            ${unanswered}
          </div>
          <div style="font-size:12px;color:#6c757d;">Unanswered</div>
        </div>
      </div>

    </div>

    <hr>

    <div class="row g-3 mb-4">

      <div class="col-md-4">
        <div class="p-3 rounded-3" style="background:#f8f9fa;">
          <div style="font-size:13px;color:#6c757d;">Marks Obtained</div>
          <div style="font-size:22px;font-weight:700;">
            ${marksObtained} / ${totalMarks}
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="p-3 rounded-3" style="background:#f8f9fa;">
          <div style="font-size:13px;color:#6c757d;">Percentage</div>
          <div style="font-size:22px;font-weight:700;">${percentage}%</div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="p-3 rounded-3" style="background:#f8f9fa;">
          <div style="font-size:13px;color:#6c757d;">Result</div>
          <c:choose>
            <c:when test="${passed}">
              <div style="font-size:22px;font-weight:700;color:#198754;">
                <i class="bi bi-check-circle me-1"></i>PASS
              </div>
            </c:when>
            <c:otherwise>
              <div style="font-size:22px;font-weight:700;color:#dc3545;">
                <i class="bi bi-x-circle me-1"></i>FAIL
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

    </div>

    <div class="d-flex gap-2">
      <a href="${pageContext.request.contextPath}/student/dashboard"
         class="btn btn-primary px-4">
        <i class="bi bi-house me-1"></i>Back to Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/student/results"
         class="btn btn-outline-secondary px-4">
        <i class="bi bi-bar-chart me-1"></i>View All Results
      </a>
      <a href="${pageContext.request.contextPath}/student/exams"
         class="btn btn-outline-success px-4">
        <i class="bi bi-ui-checks-grid me-1"></i>Take Another Exam
      </a>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>