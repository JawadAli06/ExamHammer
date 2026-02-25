<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-4">
    <h3>Add Subject</h3>

    <form action="${pageContext.request.contextPath}/admin/subjects/save" method="post">

        <input type="hidden" name="subjectId" value="${subject.subjectId}" />

        <div class="form-group">
            <label>Subject Name</label>
            <input type="text" name="subjectName" class="form-control"
                   value="${subject.subjectName}" required />
        </div>

        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>