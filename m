Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB34D44A4
	for <lists+linux-s390@lfdr.de>; Thu, 10 Mar 2022 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiCJKdm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Mar 2022 05:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbiCJKdC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 05:33:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E613DE3C;
        Thu, 10 Mar 2022 02:31:59 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A9KeBY007459;
        Thu, 10 Mar 2022 10:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EvzULoCxSoTnT/bkaR4hxqTGFj6k3JUMQJYqAjs2+IY=;
 b=OrA3MSlRjefLT2Mj69+ct3cd1uG6/uc+/zIvUH4vajbyDQY3RQU48ENLnUhX7bSqKTYA
 cV9++uRt990vubnfrrh7yfdU39CDuqjboahW0XKbFC1oW1yWjQQGsrWz3tvKW4/uE8kq
 q28ytPqzM1aRbRVH4UGVxBvn9ppVq6pz2WCv6ByoaH8Wda9pBV0EH2oNRcAz5Wbkirn8
 ysh9qkb+iCt7GCtyrclPP8vXCm5rz/38km9fzKDeu8K8xgWknFq3a16imx5GD+RTp/GC
 BViaSK74bY0e6V9FCfiTAUxPkKPB0CFWCy9ujeLAC7zHUH3ymWaxUMFDjPdclD3+hL3e JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eq9svq0jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 10:31:59 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22AAIws0023626;
        Thu, 10 Mar 2022 10:31:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eq9svq0g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 10:31:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22AAMTcN004919;
        Thu, 10 Mar 2022 10:31:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3eky4jakkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 10:31:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22AAViJn55378426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 10:31:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D085204F;
        Thu, 10 Mar 2022 10:31:44 +0000 (GMT)
Received: from linux6.. (unknown [9.114.12.104])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 417C75204E;
        Thu, 10 Mar 2022 10:31:44 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, borntraeger@linux.ibm.com
Subject: [PATCH v2 1/9] s390x: Add SE hdr query information
Date:   Thu, 10 Mar 2022 10:31:04 +0000
Message-Id: <20220310103112.2156-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310103112.2156-1-frankja@linux.ibm.com>
References: <20220310103112.2156-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6V_sZltvkDkj2N_LlgopndmxHZJkHyMW
X-Proofpoint-GUID: MR0XjE2ZYU_7_U1BJ_kxNZNKRSlEDLbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We have information about the supported se header version and pcf bits
so let's expose it via the sysfs files.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/boot/uv.c        |  2 ++
 arch/s390/include/asm/uv.h |  7 ++++++-
 arch/s390/kernel/uv.c      | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index e6be155ab2e5..b100b57cf15d 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -41,6 +41,8 @@ void uv_query_info(void)
 		uv_info.max_num_sec_conf = uvcb.max_num_sec_conf;
 		uv_info.max_guest_cpu_id = uvcb.max_guest_cpu_id;
 		uv_info.uv_feature_indications = uvcb.uv_feature_indications;
+		uv_info.supp_se_hdr_ver = uvcb.supp_se_hdr_versions;
+		uv_info.supp_se_hdr_pcf = uvcb.supp_se_hdr_pcf;
 	}
 
 #ifdef CONFIG_PROTECTED_VIRTUALIZATION_GUEST
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index a2d376b8bce3..75b88247707a 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -108,7 +108,10 @@ struct uv_cb_qui {
 	u8  reserved88[158 - 136];		/* 0x0088 */
 	u16 max_guest_cpu_id;			/* 0x009e */
 	u64 uv_feature_indications;		/* 0x00a0 */
-	u8  reserveda8[200 - 168];		/* 0x00a8 */
+	u64 reserveda8;				/* 0x00a8 */
+	u64 supp_se_hdr_versions;		/* 0x00b0 */
+	u64 supp_se_hdr_pcf;			/* 0x00b8 */
+	u64 reservedc0;				/* 0x00c0 */
 } __packed __aligned(8);
 
 /* Initialize Ultravisor */
@@ -286,6 +289,8 @@ struct uv_info {
 	unsigned int max_num_sec_conf;
 	unsigned short max_guest_cpu_id;
 	unsigned long uv_feature_indications;
+	unsigned long supp_se_hdr_ver;
+	unsigned long supp_se_hdr_pcf;
 };
 
 extern struct uv_info uv_info;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a5425075dd25..852840384e75 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -392,6 +392,24 @@ static ssize_t uv_query_facilities(struct kobject *kobj,
 static struct kobj_attribute uv_query_facilities_attr =
 	__ATTR(facilities, 0444, uv_query_facilities, NULL);
 
+static ssize_t uv_query_supp_se_hdr_ver(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lx\n", uv_info.supp_se_hdr_ver);
+}
+
+static struct kobj_attribute uv_query_supp_se_hdr_ver_attr =
+	__ATTR(supp_se_hdr_ver, 0444, uv_query_supp_se_hdr_ver, NULL);
+
+static ssize_t uv_query_supp_se_hdr_pcf(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lx\n", uv_info.supp_se_hdr_pcf);
+}
+
+static struct kobj_attribute uv_query_supp_se_hdr_pcf_attr =
+	__ATTR(supp_se_hdr_pcf, 0444, uv_query_supp_se_hdr_pcf, NULL);
+
 static ssize_t uv_query_feature_indications(struct kobject *kobj,
 					    struct kobj_attribute *attr, char *buf)
 {
@@ -437,6 +455,8 @@ static struct attribute *uv_query_attrs[] = {
 	&uv_query_max_guest_cpus_attr.attr,
 	&uv_query_max_guest_vms_attr.attr,
 	&uv_query_max_guest_addr_attr.attr,
+	&uv_query_supp_se_hdr_ver_attr.attr,
+	&uv_query_supp_se_hdr_pcf_attr.attr,
 	NULL,
 };
 
-- 
2.32.0

