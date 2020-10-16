package ec.com.nashira.callcenter.auth.config;

import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import ec.com.nashira.callcenter.AppProperties;
import ec.com.nashira.callcenter.auth.constants.JwtConstants;

@Configuration
@EnableResourceServer
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

  @Autowired
  private AppProperties properties;

  private static final String ALL_ROUTES = "/**";

  @Override
  public void configure(HttpSecurity http) throws Exception {
    http.authorizeRequests()
        .antMatchers("/user/exists/**", "/user/image/**", "/user/change-password/", "/user/upload/")
        .permitAll().anyRequest().authenticated().and().cors()
        .configurationSource(corsConfigurationSource(properties));
  }

  @Bean
  public CorsConfigurationSource corsConfigurationSource(AppProperties properties) {
    CorsConfiguration config = new CorsConfiguration();
    String[] allowedDomains = properties.getAllowedAppDomains().split(",");
    config.setAllowedOrigins(Arrays.asList(allowedDomains));
    config.setAllowedMethods(Arrays.asList(JwtConstants.getAllowedMethods()));
    config.setAllowCredentials(true);
    config.setAllowedHeaders(Arrays.asList(JwtConstants.getAllowedHeaders()));
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration(ALL_ROUTES, config);
    return source;
  }

  @Bean
  public FilterRegistrationBean<CorsFilter> corsFilter() {
    FilterRegistrationBean<CorsFilter> bean =
        new FilterRegistrationBean<>(new CorsFilter(corsConfigurationSource(properties)));
    bean.setOrder(Ordered.HIGHEST_PRECEDENCE);
    return bean;
  }

}
