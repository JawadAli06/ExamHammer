<%@ include file="/WEB-INF/views/admin/header.jsp" %>

<div class="container mt-4">
    <h3 class="mb-3">All Results</h3>

    <div class="card shadow-sm border-0 rounded-4">
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Attempt ID</th>
                        <th>Student Name</th>
                        <th>Exam Name</th>
                        <th>Examiner</th>
                        <th>Score</th>
                        <th>Total Questions</th>
                        <th>Percentage</th>
                        <th>Attempted At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${results}" var="r">
                        <tr>
                            <td>${r.attemptId}</td>
                            <td>${r.student.firstName} ${r.student.lastName}</td>
                            <td>${r.exam.examName}</td>
                            <td>${r.exam.createdBy.firstName} ${r.exam.createdBy.lastName}</td>
                            <td>${r.score}</td>
                            <td>${r.totalQuestions}</td>
                            <td>${r.percentage}%</td>
                            <td>${r.attemptedAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/admin/footer.jsp" %>