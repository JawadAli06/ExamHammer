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
      Manage questions, exams, and examiner activities.
    </p>
  </div>
</div>

<hr class="mb-3">

<div class="row g-3">

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/questions'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Questions</div>
          <div class="widget-num">${totalQuestions != null ? totalQuestions : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e8f1ff;color:#0d6efd;">
          <i class="bi bi-patch-question"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/exams'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">My Exams</div>
          <div class="widget-num">${myExams != null ? myExams : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e9fbf2;color:#198754;">
          <i class="bi bi-ui-checks-grid"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/addQuestion'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Add Question</div>
          <div class="widget-num">+</div>
        </div>
        <div class="widget-icon" style="background:#fff6e8;color:#fd7e14;">
          <i class="bi bi-plus-circle"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/examiner/questions'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Question Bank</div>
          <div class="widget-num">${totalQuestions != null ? totalQuestions : 0}</div>
        </div>
        <div class="widget-icon" style="background:#ffecec;color:#dc3545;">
          <i class="bi bi-folder2-open"></i>
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
        </div>
      </div>
    </div>
  </div>

  <div class="col-lg-6">
    <div class="card border-0 shadow-sm rounded-4">
      <div class="card-body">
        <h5 class="card-title">Examiner Notes</h5>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">You can add and manage questions.</li>
          <li class="list-group-item">You can view exams created for question mapping.</li>
          <li class="list-group-item">You can expand this later with Question Bank and Results.</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>