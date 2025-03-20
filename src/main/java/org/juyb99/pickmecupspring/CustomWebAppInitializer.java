package org.juyb99.pickmecupspring;

import jakarta.servlet.*;
import org.juyb99.pickmecupspring.common.config.AppConfig;
import org.juyb99.pickmecupspring.common.filter.CrossOriginIsolationFilter;
import org.juyb99.pickmecupspring.common.filter.EncodingFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class CustomWebAppInitializer implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(AppConfig.class);

        DispatcherServlet dispatcherServlet = new DispatcherServlet(rootContext);
        ServletRegistration.Dynamic servletRegistration = servletContext.addServlet("dispatcherServlet", dispatcherServlet);
        servletRegistration.setLoadOnStartup(1);
        servletRegistration.addMapping("/");
        servletRegistration.setMultipartConfig(new MultipartConfigElement("/"));

        FilterRegistration encodingFilterRegistration = servletContext.addFilter("encodingFilter", new EncodingFilter());
        encodingFilterRegistration.addMappingForUrlPatterns(null, true, "/*");

        FilterRegistration crossOriginIsolationFilterRegistration = servletContext.addFilter("crossOriginIsolationFilter", new CrossOriginIsolationFilter());
        crossOriginIsolationFilterRegistration.addMappingForUrlPatterns(null, true, "/create-category");
    }
}
