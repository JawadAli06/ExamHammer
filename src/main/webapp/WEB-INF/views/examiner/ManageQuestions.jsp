<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<style>
  .exam-card {
    background: #fff;
    border-radius: 14px;
    border: 1px solid #e9ecef;
    box-shadow: 0 4px 14px rgba(0,0,0,.06);
    padding: 18px 20px;
    cursor: pointer;
    transition: transform .15s ease, box-shadow .15s ease;
    text-decoration: none;
    color: inherit;
    display: block;
  }
  .exam-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 22px rgba(0,0,0,.10);
    text-decoration: none;
    color: inherit;
  }
  .exam-card-title {
    font-size: 16px;
    font-weight: 700;
    color: #212529;
    margin-bottom: 6px;
  }
  .exam-card-meta {
    font-size: 13px;
    color: #6c757d;
    margin-bottom: 10px;
  }
  .exam-card-meta span {
    margin-right: 14px;
  }
  .q-count-badge {
    display: inline-block;
    padding: 4px 14px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
  }
  .q-count-has {
    background: #e9fbf2;
    color: #0f6e56;
  }
  .q-count-empty {
    background: #fff3e8;
    color: #854f0b;
  }
  .difficulty-badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;
    background: #e8f1ff;
    color: #185fa5;
  }
  .status-badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;
    background: #e9fbf2;
    color: #0f6e56;
  }
  .card-arrow {
    font-size: 20px;
    color: #adb5bd;
  }
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
  <a href="${pageContext.request.contextPath}/examiner/dashboard" class="btn btn-outline-secondary btn-sm mb-3"><i class="bi bi-arrow-left me-1"></i>Back to Dashboard</a>
    <h3 class="m-0">Manage Questions</h3>
    <p class="text-muted m-0" style="font-size:13px;">
      Click on an exam to view or manage its questions.
    </p>
  </div>
      <a href="${pageContext.request.contextPath}/examiner/addQuestion"class="btn btn-success">+ Add Question</a>
     
   
</div>

<c:if test="${empty exams}">
  <div class="alert alert-info">No exams available.</div>
</c:if>

<div class="row g-3">
  <c:forEach items="${exams}" var="e">
    <div class="col-12 col-md-6 col-xl-4">
      <a href="${pageContext.request.contextPath}/examiner/questions/exam/${e.examId}"
         class="exam-card">
        <div class="d-flex justify-content-between align-items-start">
          <div style="flex:1;">

            <div class="exam-card-title">${e.examName}</div>

            <div class="exam-card-meta">
              <span>
                <i class="bi bi-book me-1"></i>
                <c:choose>
                  <c:when test="${not empty e.subject}">${e.subject.subjectName}</c:when>
                  <c:otherwise>${e.subjectName}</c:otherwise>
                </c:choose>
              </span>
              <span>
                <i class="bi bi-clock me-1"></i>${e.durationMinutes} min
              </span>
              <span>
                <i class="bi bi-award me-1"></i>${e.totalMarks} marks
              </span>
            </div>

            <div class="d-flex align-items-center gap-2 flex-wrap">

              <span class="difficulty-badge">${e.difficulty.level}</span>
              <span class="status-badge">${e.status}</span>

              <%-- Question count badge --%>
              <c:set var="qCount" value="${questionCountMap[e.examId]}"/>
              <c:choose>
                <c:when test="${qCount > 0}">
                  <span class="q-count-badge q-count-has">
                    <i class="bi bi-patch-question me-1"></i>
                    ${qCount} Question${qCount != 1 ? 's' : ''}
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="q-count-badge q-count-empty">
                    <i class="bi bi-exclamation-circle me-1"></i>
                    No Questions
                  </span>
                </c:otherwise>
              </c:choose>

            </div>
          </div>

          <div class="card-arrow ms-2">
            <i class="bi bi-chevron-right"></i>
          </div>
        </div>
      </a>
    </div>
  </c:forEach>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>