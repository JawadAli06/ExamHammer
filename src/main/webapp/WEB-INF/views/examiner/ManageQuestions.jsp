<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="card border-0 shadow-sm rounded-4">
  <div class="card-body">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3 class="m-0">My Questions</h3>
      <a href="${pageContext.request.contextPath}/examiner/addQuestion"
         class="btn btn-success">+ Add Question</a>
    </div>

    <div class="table-responsive">
      <table class="table table-bordered align-middle">
        <thead class="table-dark">
          <tr>
            <th>#</th>
            <th>Exam</th>
            <th>Subject</th>
            <th>Question</th>
            <th>Correct</th>
            <th>Marks</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${questions}" var="q" varStatus="i">
            <tr>
              <td>${i.count}</td>
              <td>${q.exam.examName}</td>
              <td>${q.question.subject.subjectName}</td>
              <td>${q.question.questionText}</td>
              <td><span class="badge bg-primary">${q.question.correctOption}</span></td>
              <td>${q.question.marks}</td>
              <td>
                <a href="${pageContext.request.contextPath}/examiner/deleteQuestion/${q.examQuestionId}"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Delete this question?');">Delete</a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty questions}">
            <tr>
              <td colspan="7" class="text-center text-muted py-3">
                No questions added yet.
                <a href="${pageContext.request.contextPath}/examiner/addQuestion">Add one now</a>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>