<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
  .exam-info-bar {
    background: #fff;
    border-radius: 14px;
    border: 1px solid #e9ecef;
    padding: 16px 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,.05);
  }
  .exam-info-title {
    font-size: 20px;
    font-weight: 700;
    color: #212529;
    margin-bottom: 6px;
  }
  .info-pill {
    display: inline-block;
    background: #f1f3f5;
    border-radius: 20px;
    padding: 4px 12px;
    font-size: 12px;
    color: #495057;
    margin-right: 6px;
    margin-top: 4px;
  }
  .q-row:hover { background: #f8f9fa; }
  .option-pill {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    background: #e8f1ff;
    color: #185fa5;
  }
</style>

<%-- Back button + heading --%>
<div class="d-flex justify-content-between align-items-center mb-3">
  <div class="d-flex align-items-center gap-3">
    <a href="${pageContext.request.contextPath}/examiner/questions"
       class="btn btn-outline-secondary btn-sm">
      <i class="bi bi-arrow-left me-1"></i>Back
    </a>
    <div>
      <h3 class="m-0">Questions — ${exam.examName}</h3>
      <p class="text-muted m-0" style="font-size:13px;">
        All questions for this exam
      </p>
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/examiner/addQuestion"
     class="btn btn-success">+ Add Question</a>
</div>

<%-- Exam info bar --%>
<div class="exam-info-bar">
  <div class="exam-info-title">${exam.examName}</div>
  <div>
    <span class="info-pill">
      <i class="bi bi-book me-1"></i>
      <c:choose>
        <c:when test="${not empty exam.subject}">${exam.subject.subjectName}</c:when>
        <c:otherwise>${exam.subjectName}</c:otherwise>
      </c:choose>
    </span>
    <span class="info-pill">
      <i class="bi bi-speedometer me-1"></i>${exam.difficulty.level}
    </span>
    <span class="info-pill">
      <i class="bi bi-clock me-1"></i>${exam.durationMinutes} min
    </span>
    <span class="info-pill">
      <i class="bi bi-award me-1"></i>${exam.totalMarks} total marks
    </span>
    <span class="info-pill">
      <i class="bi bi-patch-question me-1"></i>
      ${empty questions ? 0 : questions.size()} question(s)
    </span>
  </div>
</div>

<%-- Questions table --%>
<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body p-0">
    <div class="table-responsive">
      <table class="table table-bordered align-middle mb-0">
        <thead class="table-dark">
          <tr>
            <th style="width:50px;">#</th>
            <th>Question</th>
            <th style="width:100px;">Option A</th>
            <th style="width:100px;">Option B</th>
            <th style="width:100px;">Option C</th>
            <th style="width:100px;">Option D</th>
            <th style="width:80px;">Correct</th>
            <th style="width:70px;">Marks</th>
            <th style="width:90px;">Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${questions}" var="q" varStatus="i">
            <tr class="q-row">
              <td class="text-center fw-bold">${i.count}</td>
              <td style="max-width:280px;">${q.question.questionText}</td>
              <td class="text-center">
                <c:choose>
                  <c:when test="${q.question.correctOption == 'A'}">
                    <span class="option-pill" style="background:#e9fbf2;color:#0f6e56;">
                      ${q.question.optionA}
                    </span>
                  </c:when>
                  <c:otherwise>${q.question.optionA}</c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <c:choose>
                  <c:when test="${q.question.correctOption == 'B'}">
                    <span class="option-pill" style="background:#e9fbf2;color:#0f6e56;">
                      ${q.question.optionB}
                    </span>
                  </c:when>
                  <c:otherwise>${q.question.optionB}</c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <c:choose>
                  <c:when test="${q.question.correctOption == 'C'}">
                    <span class="option-pill" style="background:#e9fbf2;color:#0f6e56;">
                      ${q.question.optionC}
                    </span>
                  </c:when>
                  <c:otherwise>${q.question.optionC}</c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <c:choose>
                  <c:when test="${q.question.correctOption == 'D'}">
                    <span class="option-pill" style="background:#e9fbf2;color:#0f6e56;">
                      ${q.question.optionD}
                    </span>
                  </c:when>
                  <c:otherwise>${q.question.optionD}</c:otherwise>
                </c:choose>
              </td>
              <td class="text-center">
                <span class="badge bg-primary">${q.question.correctOption}</span>
              </td>
              <td class="text-center fw-bold">${q.question.marks}</td>
              <td class="text-center">
                <a href="${pageContext.request.contextPath}/examiner/deleteQuestion/${q.examQuestionId}"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Delete this question?');">
                  <i class="bi bi-trash"></i>
                </a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty questions}">
            <tr>
              <td colspan="9" class="text-center text-muted py-4">
                No questions added for this exam yet.
                <a href="${pageContext.request.contextPath}/examiner/addQuestion">
                  Add one now
                </a>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>