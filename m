Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3E4BDFDB
	for <lists+linux-s390@lfdr.de>; Mon, 21 Feb 2022 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358548AbiBUNIX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Feb 2022 08:08:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358551AbiBUNIU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Feb 2022 08:08:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01221EAFB;
        Mon, 21 Feb 2022 05:07:57 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LAcYdE016042;
        Mon, 21 Feb 2022 13:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EZbL3x6R1FugjcHfkRqvQ0Rqsgvz6qMdmHRUKz2rBmo=;
 b=MqNi2u+d2MlutErQ0zd7po8R7LwCscdgQMyx8VY8VZ0clwv9yMMcjFcW09E6ojIEJ/+d
 Vs3uajdk9ICmeNX0sx60wYhcq9JbhIUGbCjoz5kaf4vPICCrgIPMsHnBCJbk/874FWvv
 crVhquO/ljtfcr1i/eg5rgXgnWCGOwcxCwrJjZHPS3Q54swfHZWzzLIFOxpMyh4aAc3G
 gvGAdQV/KhBc2oYgnL5+8B+rAaQWEoG1Wew71ez1x6RTcueN4VeKWkj4px4kRalVaG9w
 gGavjNd8+WdJrCeYzlbBPCQVnP82MgZzTUfc3lfQdZFHBGKIoefS7T+PzpBnb36qvSAP gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec65aq0mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:56 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21LCxFT4020908;
        Mon, 21 Feb 2022 13:07:55 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec65aq0m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21LCuoO7027619;
        Mon, 21 Feb 2022 13:07:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3ear68stnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 13:07:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21LD7nns51315198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:07:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD8764C052;
        Mon, 21 Feb 2022 13:07:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BAD94C044;
        Mon, 21 Feb 2022 13:07:49 +0000 (GMT)
Received: from t46lp57.lnxne.boe (unknown [9.152.108.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 13:07:49 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com
Subject: [kvm-unit-tests PATCH v2 7/8] s390x: Add tests for TSCH
Date:   Mon, 21 Feb 2022 14:07:45 +0100
Message-Id: <20220221130746.1754410-8-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220221130746.1754410-1-nrb@linux.ibm.com>
References: <20220221130746.1754410-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DNaZpdXN94icLi6Xqs5FQdlpb2aiSrOK
X-Proofpoint-ORIG-GUID: A0qOd1gTqz8VB1nFyg4WwwY1Q8-D_QXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_06,2022-02-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

TSCH has two special cases which need to be tested:

- unaligned address. We test for misalignment by 1 and 2 bytes.
- channel not operational
- bit 47 in SID not set

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 s390x/css.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/s390x/css.c b/s390x/css.c
index 021eb12573c0..b2e027c99848 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -568,6 +568,41 @@ static void test_pmcw_bit5(void)
 	report_prefix_pop();
 }
 
+static void test_tsch(void)
+{
+	const int align_to = 4;
+	struct irb irb;
+	int cc;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+
+	report_prefix_push("Unaligned");
+	for (int i = 1; i < align_to; i *= 2) {
+		report_prefix_pushf("%d", i);
+
+		expect_pgm_int();
+		tsch(test_device_sid, (struct irb *)(alignment_test_page + i));
+		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
+
+		report_prefix_pop();
+	}
+	report_prefix_pop();
+
+	report_prefix_push("Invalid subchannel number");
+	cc = tsch(0x0001ffff, &irb);
+	report(cc == 3, "Channel not operational");
+	report_prefix_pop();
+
+	report_prefix_push("Bit 47 in SID is zero");
+	expect_pgm_int();
+	tsch(0x0000ffff, &irb);
+	check_pgm_int_code(PGM_INT_CODE_OPERAND);
+	report_prefix_pop();
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
@@ -585,6 +620,7 @@ static struct {
 	{ "ssch", test_ssch },
 	{ "stsch", test_stsch },
 	{ "pmcw bit 5 ignored", test_pmcw_bit5 },
+	{ "tsch", test_tsch },
 	{ NULL, NULL }
 };
 
-- 
2.31.1

