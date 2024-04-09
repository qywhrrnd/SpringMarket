package com.example.springmarket.model.report;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ReportDTO {
	private String reporter;
	private String report_subject;
	private String report_userid;
	private String report_contents;
	private String link;
	private int idx;

}
