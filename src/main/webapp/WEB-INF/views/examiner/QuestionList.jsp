<
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h3>Question List</h3>

<a href="/examiner/addQuestion" class="btn btn-success mb-3">Add Question</a>

<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Question</th>
            <th>Marks</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${questions}" var="q">
            <tr>
                <td>${q.questionId}</td>
                <td>${q.questionText}</td>
                <td>${q.marks}</td>
                <td>
                    <a href="/examiner/deleteQuestion/${q.questionId}" class="btn btn-danger btn-sm">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
