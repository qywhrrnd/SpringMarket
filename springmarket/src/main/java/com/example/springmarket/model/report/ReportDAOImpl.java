package com.example.springmarket.model.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAOImpl implements ReportDAO{

	@Autowired
	SqlSession session;

	@Override
	public void insertReport(ReportDTO dto) {
		session.insert("report.insert_Report", dto);

	}
	@Override
	public List<ReportDTO> report_list() {
		return session.selectList("report.list_report");
	}
	
	
	@Override
	public void report_delete(int idx) {
		session.delete("report.delete_report", idx);
	}

}
