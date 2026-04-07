<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

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
    <h2 class="m-0">Examiner Dashboard</h2>
    <p class="text-muted m-0" style="font-size:14px;">
      Manage subjects, exams, questions, and results.
    </p>
  </div>
</div>

<hr class="mb-3">

<div class="row g-3">

  <!-- Total Subjects -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/subjects'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Subjects</div>
          <div class="widget-num">${subjectCount != null ? subjectCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e8f1ff;color:#0d6efd;">
          <i class="bi bi-book"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Total Exams -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/exams'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Exams</div>
          <div class="widget-num">${examCount != null ? examCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e9fbf2;color:#198754;">
          <i class="bi bi-ui-checks-grid"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- My Questions -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/questions'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">My Questions</div>
          <div class="widget-num">${questionCount != null ? questionCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#fff6e8;color:#fd7e14;">
          <i class="bi bi-patch-question"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- My Results -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/results'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">My Exam Results</div>
          <div class="widget-num">${resultCount != null ? resultCount : 0}</div>
        </div>
        <div class="widget-icon" style="background:#ffecec;color:#dc3545;">
          <i class="bi bi-bar-chart-line"></i>
        </div>
      </div>
    </div>
  </div>

</div>

<div class="row g-3 mt-2">
  <div class="col-lg-6">
    <div class="card border-0 shadow-sm rounded-4">
      <div class="card-body">
        <h5 class="card-title">Quick Actions</h5>
        <div class="d-grid gap-2">
          <a href="${pageContext.request.contextPath}/examiner/addQuestion" class="btn btn-primary">Add Question</a>
          <a href="${pageContext.request.contextPath}/examiner/questions" class="btn btn-outline-success">Manage Questions</a>
          <a href="${pageContext.request.contextPath}/examiner/exams" class="btn btn-outline-secondary">View Exams</a>
          <a href="${pageContext.request.contextPath}/examiner/results" class="btn btn-outline-danger">View Results</a>
        </div>
      </div>
    </div>
  </div>

  <div class="col-lg-6">
    <div class="card border-0 shadow-sm rounded-4">
      <div class="card-body">
        <h5 class="card-title">Examiner Notes</h5>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">All admin + examiner subjects are visible here.</li>
          <li class="list-group-item">All admin + examiner exams are visible here.</li>
          <li class="list-group-item">My Questions count shows only questions added by this examiner.</li>
          <li class="list-group-item">My Exam Results shows student attempts on this examiner's exams.</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>
