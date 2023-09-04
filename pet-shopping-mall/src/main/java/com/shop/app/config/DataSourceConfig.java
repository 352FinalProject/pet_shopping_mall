package com.shop.app.config;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import oracle.jdbc.pool.OracleDataSource;

@Configuration
public class DataSourceConfig {

	@Bean
	public DataSource dataSource() throws SQLException {
		OracleDataSource dataSource = new OracleDataSource();
		String path = this.getClass().getResource("/Wallet_Q9D66TYPJ7NUFZ98").getPath();
		String os = System.getProperty("os.name").toLowerCase(); 
		System.out.println(os);
		if(os.contains("win"))
			path = path.replaceFirst("/", "");
		
		System.out.println(path); 
		dataSource.setURL("jdbc:oracle:thin:@q9d66typj7nufz98_high?TNS_ADMIN=" + path);
		dataSource.setUser("pet");
		dataSource.setPassword("KingFinalProject352!");
		return dataSource;
	}
}