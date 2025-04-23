<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Engineering Resume Builder</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f3f3f3; }
        .container { max-width: 800px; margin: 20px auto; padding: 20px; }
        .form-section {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 15px; }
        label {
            display: block;
            margin-bottom: 5px;
            color: #2b579a;
            font-weight: 600;
        }
        input, select, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .dynamic-section { margin-top: 15px; border-top: 1px dashed #ddd; padding-top: 15px; }
        .add-btn {
            background: #2b579a;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        .submit-btn {
            background: #217346;
            color: white;
            padding: 12px 25px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="container">
    <form action="resume" method="post" enctype="multipart/form-data">

        <!-- Personal Details Section -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Personal Information</h2>
            <div class="form-group">
                <label>Upload Photo (JPEG/PNG, max 2MB):</label>
                <input type="file" name="photo" accept="image/jpeg,image/png" required>
            </div>
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="fullName" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="tel" name="phone" pattern="[0-9]{10}" required>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <textarea name="address" rows="2" required></textarea>
            </div>
            <div class="form-group">
                <label>LinkedIn Profile:</label>
                <input type="url" name="linkedin">
            </div>
            <div class="form-group">
                <label>GitHub Profile:</label>
                <input type="url" name="github">
            </div>
        </div>

        <!-- Career Objective -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Career Objective</h2>
            <div class="form-group">
                <textarea name="objective" rows="3" required></textarea>
            </div>
        </div>

        <!-- Education Section -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Education</h2>
            <!-- 10th Board -->
            <div class="dynamic-section">
                <h4>10th Board</h4>
                <div class="form-group">
                    <label>School/Board:</label>
                    <input type="text" name="board10" required>
                </div>
                <div class="form-group">
                    <label>Year:</label>
                    <input type="text" name="year10" required>
                </div>
                <div class="form-group">
                    <label>Percentage/CGPA:</label>
                    <input type="text" name="gpa10" required>
                </div>
            </div>
            <!-- 12th Board -->
            <div class="dynamic-section">
                <h4>12th Board</h4>
                <div class="form-group">
                    <label>School/Board:</label>
                    <input type="text" name="board12" required>
                </div>
                <div class="form-group">
                    <label>Year:</label>
                    <input type="text" name="year12" required>
                </div>
                <div class="form-group">
                    <label>Percentage/CGPA:</label>
                    <input type="text" name="gpa12" required>
                </div>
            </div>
            <!-- College Degrees (dynamic as before) -->
            <div id="educationSection">
                <div class="dynamic-section">
                    <div class="form-group">
                        <label>Degree:</label>
                        <select name="degree" required>
                            <option value="B.Tech">Bachelor of Technology</option>
                            <option value="M.Tech">Master of Technology</option>
                            <option value="BE">Bachelor of Engineering</option>
                            <option value="ME">Master of Engineering</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>University/Institute:</label>
                        <input type="text" name="university" required>
                    </div>
                    <div class="form-group">
                        <label>Major:</label>
                        <input type="text" name="major" required>
                    </div>
                    <div class="form-group">
                        <label>CGPA/Percentage:</label>
                        <input type="text" name="gpa" required>
                    </div>
                </div>
            </div>
            <button type="button" class="add-btn" onclick="addEducation()">+ Add Another Degree</button>
        </div>

        <!-- Technical Skills Section -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Technical Skills</h2>
            <div id="skillsSection">
                <div class="dynamic-section">
                    <div class="form-group">
                        <label>Skill Category:</label>
                        <input type="text" name="skillCategory" required>
                    </div>
                    <div class="form-group">
                        <label>Skills (comma separated):</label>
                        <textarea name="skills" rows="3" required></textarea>
                    </div>
                </div>
            </div>
            <button type="button" class="add-btn" onclick="addSkill()">+ Add Skill Category</button>
        </div>

        <!-- Projects Section -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Projects</h2>
            <div id="projectsSection">
                <div class="dynamic-section">
                    <div class="form-group">
                        <label>Project Title:</label>
                        <input type="text" name="projectTitle" required>
                    </div>
                    <div class="form-group">
                        <label>Description:</label>
                        <textarea name="projectDesc" rows="2" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Technologies Used:</label>
                        <input type="text" name="projectTech" required>
                    </div>
                    <div class="form-group">
                        <label>Project Link (optional):</label>
                        <input type="url" name="projectLink">
                    </div>
                </div>
            </div>
            <button type="button" class="add-btn" onclick="addProject()">+ Add Project</button>
        </div>

        <!-- Achievements, Certifications, Languages, Hobbies (optional) -->
        <div class="form-section">
            <h2 style="color: #2b579a;">Achievements</h2>
            <div class="form-group">
                <textarea name="achievements" rows="2"></textarea>
            </div>
        </div>
        <div class="form-section">
            <h2 style="color: #2b579a;">Certifications</h2>
            <div class="form-group">
                <textarea name="certifications" rows="2"></textarea>
            </div>
        </div>
        <div class="form-section">
            <h2 style="color: #2b579a;">Languages Known</h2>
            <div class="form-group">
                <input type="text" name="languages">
            </div>
        </div>
        <div class="form-section">
            <h2 style="color: #2b579a;">Hobbies</h2>
            <div class="form-group">
                <input type="text" name="hobbies">
            </div>
        </div>

        <input type="submit" class="submit-btn" value="Generate Resume">
    </form>
</div>

<script>
    function addEducation() {
        const section = document.createElement('div');
        section.className = 'dynamic-section';
        section.innerHTML = `
        <div class="form-group">
            <label>Degree:</label>
            <select name="degree" required>
                <option value="B.Tech">Bachelor of Technology</option>
                <option value="M.Tech">Master of Technology</option>
                <option value="BE">Bachelor of Engineering</option>
                <option value="ME">Master of Engineering</option>
            </select>
        </div>
        <div class="form-group">
            <label>University/Institute:</label>
            <input type="text" name="university" required>
        </div>
        <div class="form-group">
            <label>Major:</label>
            <input type="text" name="major" required>
        </div>
        <div class="form-group">
            <label>CGPA/Percentage:</label>
            <input type="text" name="gpa" required>
        </div>`;
        document.getElementById('educationSection').appendChild(section);
    }

    function addSkill() {
        const section = document.createElement('div');
        section.className = 'dynamic-section';
        section.innerHTML = `
        <div class="form-group">
            <label>Skill Category:</label>
            <input type="text" name="skillCategory" required>
        </div>
        <div class="form-group">
            <label>Skills (comma separated):</label>
            <textarea name="skills" rows="3" required></textarea>
        </div>`;
        document.getElementById('skillsSection').appendChild(section);
    }

    function addProject() {
        const section = document.createElement('div');
        section.className = 'dynamic-section';
        section.innerHTML = `
            <div class="form-group">
                <label>Project Title:</label>
                <input type="text" name="projectTitle" required>
            </div>
            <div class="form-group">
                <label>Description:</label>
                <textarea name="projectDesc" rows="2" required></textarea>
            </div>
            <div class="form-group">
                <label>Technologies Used:</label>
                <input type="text" name="projectTech" required>
            </div>
            <div class="form-group">
                <label>Project Link (optional):</label>
                <input type="url" name="projectLink">
            </div>`;
        document.getElementById('projectsSection').appendChild(section);
    }
</script>
</body>
</html>
