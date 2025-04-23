package com.example.resumebuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/resume")
@MultipartConfig
public class ResumeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Handle photo upload
        String base64Photo = "";
        try {
            Part filePart = request.getPart("photo");
            if (filePart != null && filePart.getSize() > 0) {
                try (InputStream fileContent = filePart.getInputStream()) {
                    byte[] photoBytes = IOUtils.toByteArray(fileContent);
                    base64Photo = Base64.getEncoder().encodeToString(photoBytes);
                }
            }
        } catch (Exception e) {
            // If photo not present, leave as empty string
        }

        // 2. Get personal info
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String linkedin = request.getParameter("linkedin");
        String github = request.getParameter("github");
        String objective = request.getParameter("objective");

        // 3. Get 10th/12th board info
        String board10 = request.getParameter("board10");
        String year10 = request.getParameter("year10");
        String gpa10 = request.getParameter("gpa10");

        String board12 = request.getParameter("board12");
        String year12 = request.getParameter("year12");
        String gpa12 = request.getParameter("gpa12");

        // 4. Get college education info (multiple entries supported)
        String[] degrees = request.getParameterValues("degree");
        String[] universities = request.getParameterValues("university");
        String[] majors = request.getParameterValues("major");
        String[] gpas = request.getParameterValues("gpa");

        List<Education> educationList = new ArrayList<>();
        if (degrees != null && universities != null && majors != null && gpas != null) {
            int count = Math.min(Math.min(degrees.length, universities.length), Math.min(majors.length, gpas.length));
            for (int i = 0; i < count; i++) {
                educationList.add(new Education(
                        degrees[i],
                        universities[i],
                        majors[i],
                        gpas[i]
                ));
            }
        }

        // 5. Get skills info (multiple categories supported)
        String[] skillCategories = request.getParameterValues("skillCategory");
        String[] skills = request.getParameterValues("skills");

        List<SkillCategory> skillList = new ArrayList<>();
        if (skillCategories != null && skills != null) {
            int count = Math.min(skillCategories.length, skills.length);
            for (int i = 0; i < count; i++) {
                skillList.add(new SkillCategory(
                        skillCategories[i],
                        skills[i]
                ));
            }
        }

        // 6. Get projects info (multiple projects supported)
        String[] projectTitles = request.getParameterValues("projectTitle");
        String[] projectDescs = request.getParameterValues("projectDesc");
        String[] projectTechs = request.getParameterValues("projectTech");
        String[] projectLinks = request.getParameterValues("projectLink");

        List<Project> projectList = new ArrayList<>();
        if (projectTitles != null && projectDescs != null && projectTechs != null) {
            int count = Math.min(Math.min(projectTitles.length, projectDescs.length), projectTechs.length);
            for (int i = 0; i < count; i++) {
                String link = (projectLinks != null && i < projectLinks.length) ? projectLinks[i] : "";
                projectList.add(new Project(
                        projectTitles[i],
                        projectDescs[i],
                        projectTechs[i],
                        link
                ));
            }
        }

        // 7. Other fields
        String achievements = request.getParameter("achievements");
        String certifications = request.getParameter("certifications");
        String languages = request.getParameter("languages");
        String hobbies = request.getParameter("hobbies");

        // 8. Set attributes for JSP
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("photo", base64Photo);
        request.setAttribute("address", address);
        request.setAttribute("linkedin", linkedin);
        request.setAttribute("github", github);
        request.setAttribute("objective", objective);

        request.setAttribute("board10", board10);
        request.setAttribute("year10", year10);
        request.setAttribute("gpa10", gpa10);
        request.setAttribute("board12", board12);
        request.setAttribute("year12", year12);
        request.setAttribute("gpa12", gpa12);

        request.setAttribute("education", educationList);
        request.setAttribute("skills", skillList);
        request.setAttribute("projects", projectList);

        request.setAttribute("achievements", achievements);
        request.setAttribute("certifications", certifications);
        request.setAttribute("languages", languages);
        request.setAttribute("hobbies", hobbies);

        // 9. Forward to result.jsp
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    // Simple POJO for Education
    public static class Education {
        private final String degree;
        private final String university;
        private final String major;
        private final String gpa;

        public Education(String degree, String university, String major, String gpa) {
            this.degree = degree;
            this.university = university;
            this.major = major;
            this.gpa = gpa;
        }

        public String getDegree() { return degree; }
        public String getUniversity() { return university; }
        public String getMajor() { return major; }
        public String getGpa() { return gpa; }
    }

    // Simple POJO for Skill Category
    public static class SkillCategory {
        private final String category;
        private final String items;

        public SkillCategory(String category, String items) {
            this.category = category;
            this.items = items;
        }

        public String getCategory() { return category; }
        public String getItems() { return items; }
    }

    // Simple POJO for Project
    public static class Project {
        private final String title;
        private final String description;
        private final String technologies;
        private final String link;

        public Project(String title, String description, String technologies, String link) {
            this.title = title;
            this.description = description;
            this.technologies = technologies;
            this.link = link;
        }

        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public String getTechnologies() { return technologies; }
        public String getLink() { return link; }
    }
}
