<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ExamHammer Student Panel</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

<style>
  :root{
    --sidebar-w: 260px;
    --sidebar-bg: #343a40;
  }
  body { background: #f5f6fa; }

  .layout { display:flex; min-height:100vh; }

  #sidebar{
    width: var(--sidebar-w);
    min-height:100vh;
    background: var(--sidebar-bg);
    color:#fff;
    position:fixed;
    top:0; left:0; bottom:0;
    padding-top:10px;
    overflow-y:auto;
    transition: transform .25s ease;
    z-index:1040;
  }

  #sidebar a{
    color:#fff;
    text-decoration:none;
    display:block;
    padding:10px 14px;
    font-size:14px;
    border-radius:10px;
    margin:2px 10px;
  }

  #sidebar a:hover{
    background:#495057;
  }

  #mainContent{
    flex:1;
    width:100%;
    margin-left: var(--sidebar-w);
    padding:16px 18px;
    transition: margin-left .25s ease;
  }

  .topbar{
    background:#fff;
    border:1px solid #e9ecef;
    border-radius:16px;
    padding:10px 12px;
    margin-bottom:14px;
    position:sticky;
    top:0;
    z-index:1030;
  }

  .avatar{
    width:38px;
    height:38px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #e9ecef;
  }

  #sidebarOverlay{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.35);
    display:none;
    z-index:1035;
  }

  body.sidebar-collapsed #sidebar{ transform: translateX(-100%); }
  body.sidebar-collapsed #mainContent{ margin-left: 0; }

  @media (max-width: 991.98px){
    #mainContent{ margin-left: 0; }
    #sidebar{ transform: translateX(-100%); }
    body.sidebar-open #sidebar{ transform: translateX(0); }
    body.sidebar-open #sidebarOverlay{ display:block; }
  }
</style>
</head>

<body class="sidebar-collapsed">

<div id="sidebarOverlay" onclick="closeSidebar()"></div>

<div class="layout">

  <div id="sidebar">
    <h4 class="p-3 m-0">Student Panel</h4>

    <div class="px-3 pb-2" style="font-size:14px;">
      <c:if test="${not empty sessionScope.user}">
        <div class="mb-2">
          Welcome, <b>${sessionScope.user.firstName}</b>
        </div>
      </c:if>
    </div>

    <a href="${pageContext.request.contextPath}/student/dashboard">
      <i class="bi bi-grid me-2"></i>Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/student/exams">
      <i class="bi bi-ui-checks-grid me-2"></i>Available Exams
    </a>

    <a href="${pageContext.request.contextPath}/student/results">
      <i class="bi bi-bar-chart me-2"></i>My Results
    </a>

    <hr style="border-color:rgba(255,255,255,0.2); margin: 12px 14px;">

    <a href="${pageContext.request.contextPath}/logout" class="text-warning">
      <i class="bi bi-box-arrow-right me-2"></i>Logout
    </a>
  </div>

  <div id="mainContent">

    <div class="topbar d-flex align-items-center justify-content-between">

      <div class="d-flex align-items-center gap-2">
        <button class="btn btn-outline-secondary btn-sm" type="button" onclick="toggleSidebar()">
          <i class="bi bi-list"></i>
        </button>

        <div>
          <div class="fw-bold">ExamHammer</div>
          <div class="text-muted" style="font-size:13px;">Student Panel</div>
        </div>
      </div>

      <div class="d-flex align-items-center gap-2">
        <div class="d-none d-md-block">
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
            <input class="form-control" placeholder="Search...">
          </div>
        </div>

        <div class="dropdown">
          <a class="d-flex align-items-center text-decoration-none"
             href="#"
             role="button"
             data-bs-toggle="dropdown"
             aria-expanded="false">
            <img class="avatar" src="${pageContext.request.contextPath}/images/images.png" alt="profile">
          </a>

          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/profile">My Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/changePassword">Change Password</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
          </ul>
        </div>
      </div>

    </div>