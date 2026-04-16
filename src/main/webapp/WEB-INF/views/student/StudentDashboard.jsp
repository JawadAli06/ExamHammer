<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/student/student_header.jsp" %>

<style>
  .widget-card{
    border: 0;
    border-radius: 18px;
    box-shadow: 0 10px 25px rgba(0,0,0,.07);
    padding: 16px;
    cursor: pointer;
    transition: transform .15s ease;
    background: #fff;
  }
  .widget-card:hover{ transform: translateY(-2px); }

  .widget-label{
    font-size: 12px;
    font-weight: 800;
    letter-spacing: .5px;
    text-transform: uppercase;
    color: #6c757d;
  }

  .widget-num{
    font-size: 34px;
    font-weight: 900;
    margin-top: 2px;
    line-height: 1.1;
  }

  .widget-icon{
    width: 46px;
    height: 46px;
    border-radius: 14px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size: 22px;
  }
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
    <h2 class="m-0">Student Dashboard</h2>
    <p class="text-muted m-0" style="font-size:14px;">
      View active exams and start your test.
    </p>
  </div>
</div>

<hr class="mb-3">

<div class="row g-3">

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/student/exams'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Active Exams</div>
          <div class="widget-num">${activeExamsCount != null ? activeExamsCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e8f1ff;color:#0d6efd;">
          <i class="bi bi-ui-checks-grid"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/student/results'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">My Results</div>
          <div class="widget-num">${resultCount != null ? resultCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e9fbf2;color:#198754;">
          <i class="bi bi-bar-chart"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
  <div class="widget-card"
       onclick="location.href='${pageContext.request.contextPath}/student/progress'">
    <div class="d-flex justify-content-between align-items-center">
      <div>
        <div class="widget-label">My Progress</div>
        <div class="widget-num">${progressCount != null ? progressCount : 0}</div>
      </div>
      <div class="widget-icon" style="background:#fff6e8;color:#fd7e14;">
        <i class="bi bi-graph-up"></i>
      </div>
    </div>
  </div>
</div>

</div>

<div class="row g-3 mt-2">
  <div class="col-lg-12">
    <div class="card border-0 shadow-sm rounded-4">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="card-title m-0">Active Exams</h5>
          <a href="${pageContext.request.contextPath}/student/exams" class="btn btn-sm btn-primary">View All</a>
        </div>

        <div class="table-responsive">
          <table class="table table-bordered align-middle">
            <thead class="table-dark">
              <tr>
                <th>ID</th>
                <th>Exam Name</th>
                <th>Subject</th>
                <th>Difficulty</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${activeExams}" var="e">
                <tr>
                  <td>${e.examId}</td>
                  <td>${e.examName}</td>
                  <td>${e.subjectName}</td>
                  <td>${e.difficulty.level}</td>
                  <td>${e.status}</td>
                  <td>
                    <a href="${pageContext.request.contextPath}/student/exam/${e.examId}" class="btn btn-info btn-sm">
                      View Exam
                    </a>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty activeExams}">
                <tr>
                  <td colspan="6" class="text-center text-muted">No active exams available.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>

      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/student/student_footer.jsp" %>