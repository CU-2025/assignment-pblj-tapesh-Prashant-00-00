<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${fullName}'s Resume</title>
    <style>
        body { font-family: 'Calibri', Arial, sans-serif; background: #f5f5f5; margin: 0; padding: 0; }
        .container { max-width: 800px; margin: 30px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px #ccc; }
        .header { display: flex; align-items: center; border-bottom: 2px solid #2b579a; padding-bottom: 20px; margin-bottom: 30px; }
        .profile-photo { width: 120px; height: 150px; object-fit: cover; border: 2px solid #2b579a; border-radius: 6px; margin-right: 30px; }
        .info { flex: 1; }
        .info h1 { margin: 0; color: #2b579a; font-size: 2.2em; }
        .info p { margin: 4px 0; color: #444; }
        .links a { color: #2b579a; margin-right: 10px; text-decoration: none; }
        h2 { color: #2b579a; border-bottom: 1px solid #eee; padding-bottom: 5px; margin-top: 35px; }
        .section { margin-bottom: 25px; }
        .education-entry, .skill-entry, .project-entry { margin-bottom: 18px; }
        .download-btn {
            background: #2b579a;
            color: white;
            padding: 12px 28px;
            border: none;
            border-radius: 5px;
            font-size: 1.1em;
            cursor: pointer;
            margin-top: 30px;
        }
        @media print {
            .download-btn { display: none; }
            body, .container { background: white !important; box-shadow: none !important; }
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
</head>
<body>
<div class="container" id="resume-content">
    <div class="header">
        <c:if test="${not empty photo}">
            <img class="profile-photo" src="data:image/png;base64,${photo}" alt="Profile Photo"/>
        </c:if>
        <div class="info">
            <h1>${fullName}</h1>
            <p>Email: ${email}</p>
            <p>Phone: ${phone}</p>
            <p>Address: ${address}</p>
            <div class="links">
                <c:if test="${not empty linkedin}">
                    <a href="${linkedin}" target="_blank">LinkedIn</a>
                </c:if>
                <c:if test="${not empty github}">
                    <a href="${github}" target="_blank">GitHub</a>
                </c:if>
            </div>
        </div>
    </div>

    <div class="section">
        <h2>Career Objective</h2>
        <p>${objective}</p>
    </div>

    <div class="section">
        <h2>Education</h2>
        <div class="education-entry">
            <strong>10th Board:</strong> ${board10}<br/>
            <strong>Year:</strong> ${year10}<br/>
            <strong>CGPA/Percentage:</strong> ${gpa10}
        </div>
        <div class="education-entry">
            <strong>12th Board:</strong> ${board12}<br/>
            <strong>Year:</strong> ${year12}<br/>
            <strong>CGPA/Percentage:</strong> ${gpa12}
        </div>
        <c:forEach var="edu" items="${education}">
            <div class="education-entry">
                <strong>${edu.degree}</strong> in ${edu.major}<br/>
                    ${edu.university}<br/>
                CGPA/Percentage: ${edu.gpa}
            </div>
        </c:forEach>
    </div>

    <div class="section">
        <h2>Technical Skills</h2>
        <c:forEach var="skill" items="${skills}">
            <div class="skill-entry">
                <strong>${skill.category}:</strong> ${skill.items}
            </div>
        </c:forEach>
    </div>

    <div class="section">
        <h2>Projects</h2>
        <c:forEach var="project" items="${projects}">
            <div class="project-entry">
                <strong>${project.title}</strong><br/>
                <em>${project.technologies}</em><br/>
                <span>${project.description}</span>
                <c:if test="${not empty project.link}">
                    <br/><a href="${project.link}" target="_blank">Project Link</a>
                </c:if>
            </div>
        </c:forEach>
    </div>

    <c:if test="${not empty achievements}">
        <div class="section">
            <h2>Achievements</h2>
            <p>${achievements}</p>
        </div>
    </c:if>

    <c:if test="${not empty certifications}">
        <div class="section">
            <h2>Certifications</h2>
            <p>${certifications}</p>
        </div>
    </c:if>

    <c:if test="${not empty languages}">
        <div class="section">
            <h2>Languages Known</h2>
            <p>${languages}</p>
        </div>
    </c:if>

    <c:if test="${not empty hobbies}">
        <div class="section">
            <h2>Hobbies</h2>
            <p>${hobbies}</p>
        </div>
    </c:if>

    <button class="download-btn" onclick="downloadPDF()">Download as PDF</button>
</div>
<script>
    function downloadPDF() {
        window.scrollTo(0, 0);
        setTimeout(function() {
            const element = document.getElementById('resume-content');
            html2pdf().set({
                margin: 0.5,
                filename: '${fullName}_Resume.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2, scrollY: 0 },
                jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
            }).from(element).save();
        }, 3000); // 300ms is usually enough; increase if needed
    }

</script>
</body>
</html>
