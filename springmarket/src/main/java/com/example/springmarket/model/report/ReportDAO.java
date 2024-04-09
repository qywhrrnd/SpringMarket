package com.example.springmarket.model.report;

import java.util.List;


public interface ReportDAO {
	void insertReport(ReportDTO dto);
	List<ReportDTO> report_list();
	void report_delete(int idx);

}
