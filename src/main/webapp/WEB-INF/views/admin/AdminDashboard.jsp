<%@ include file="/WEB-INF/views/admin/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  .dash-title{ margin: 4px 0 0; }
  .dash-sub{ font-size:14px; }

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
    <h2 class="dash-title">Admin Dashboard</h2>
    <p class="text-muted m-0 dash-sub">
      Manage users, subjects, and exams from the sidebar.
    </p>
  </div>
</div>

<hr class="mb-3">

<!-- 4 Widgets -->
<div class="row g-3">

  <!-- Total Subjects -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/admin/subjects'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Subjects</div>
          <div class="widget-num">${totalSubjects != null ? totalSubjects : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e8f1ff;color:#0d6efd;">
          <i class="bi bi-journal-text"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Total Exams -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/admin/exams'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Exams Created</div>
          <div class="widget-num">${totalExams != null ? totalExams : 0}</div>
        </div>
        <div class="widget-icon" style="background:#e9fbf2;color:#198754;">
          <i class="bi bi-ui-checks-grid"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Total Users -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/admin/users'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Total Users</div>
          <div class="widget-num">${totalUsers != null ? totalUsers : 0}</div>
        </div>
        <div class="widget-icon" style="background:#fff6e8;color:#fd7e14;">
          <i class="bi bi-people"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- 4th Widget: Active Exams -->
  <div class="col-12 col-md-6 col-xl-3">
    <div class="widget-card" onclick="location.href='${pageContext.request.contextPath}/admin/exams?status=ACTIVE'">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="widget-label">Active Exams</div>
          <div class="widget-num">${activeExams != null ? activeExams : 0}</div>
        </div>
        <div class="widget-icon" style="background:#ffecec;color:#dc3545;">
          <i class="bi bi-lightning-charge"></i>
        </div>
      </div>
    </div>
  </div>

</div>

<!-- Optional: keep your old 3 cards below if you want, or remove -->
<!-- If you want, I can also add “Recent Exams / Recent Users” tables later -->

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>