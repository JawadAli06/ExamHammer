<%@ include file="/WEB-INF/views/admin/header.jsp" %>

<div class="container mt-4">

    <a href="${pageContext.request.contextPath}/admin/exams" 
       class="btn btn-secondary mb-3">Back</a>

    <div class="card p-4 shadow-sm">
        <h3>${exam.examName}</h3>
        <hr>

        <p><strong>Subject:</strong> ${exam.subject.subjectName}</p>
        <p><strong>Difficulty:</strong> ${exam.difficulty.level}</p>
        <p><strong>Duration:</strong> ${exam.durationMinutes} mins</p>
        <p><strong>Total Marks:</strong> ${exam.totalMarks}</p>
        <p><strong>Status:</strong> ${exam.status}</p>

        <p><strong>Created By:</strong> 
            ${exam.createdBy.firstName} ${exam.createdBy.lastName}
        </p>
    </div>

</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>