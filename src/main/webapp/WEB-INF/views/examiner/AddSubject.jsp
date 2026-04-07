<%@ include file="/WEB-INF/views/examiner/examiner_header.jsp" %>

<div class="container mt-4">
    <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body">
            <h3 class="mb-4">Add Subject</h3>

            <form action="${pageContext.request.contextPath}/examiner/saveSubject" method="post">
                <div class="mb-3">
                    <label class="form-label">Subject Name</label>
                    <input type="text" name="subjectName" class="form-control" required />
                </div>

                <button type="submit" class="btn btn-primary">Save Subject</button>
                <a href="${pageContext.request.contextPath}/examiner/dashboard" class="btn btn-secondary">Back</a>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/examiner/examiner_footer.jsp" %>