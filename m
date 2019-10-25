Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19FE51EE
	for <lists+linux-s390@lfdr.de>; Fri, 25 Oct 2019 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409747AbfJYRGm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 25 Oct 2019 13:06:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409654AbfJYRGl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 13:06:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PH3fNh081382
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv4ax9qgw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 13:06:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Fri, 25 Oct 2019 18:06:39 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 18:06:37 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PH6aKi51249236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 17:06:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A0D7A404D;
        Fri, 25 Oct 2019 17:06:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F46A4051;
        Fri, 25 Oct 2019 17:06:36 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Oct 2019 17:06:35 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: expose ram_size and max_ram_size
Date:   Fri, 25 Oct 2019 19:06:32 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19102517-0028-0000-0000-000003AF94A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102517-0029-0000-0000-00002471CB94
Message-Id: <1572023194-14370-4-git-send-email-imbrenda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250157
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Expose ram_size and max_ram_size through accessor functions.

We only use get_ram_size in an upcoming patch, but having an accessor
for the other one does not hurt.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 lib/s390x/sclp.h |  2 ++
 lib/s390x/sclp.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index f00c3df..6d40fb7 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -272,5 +272,7 @@ void sclp_console_setup(void);
 void sclp_print(const char *str);
 int sclp_service_call(unsigned int command, void *sccb);
 void sclp_memory_setup(void);
+uint64_t get_ram_size(void);
+uint64_t get_max_ram_size(void);
 
 #endif /* SCLP_H */
diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 56fca0c..7798f04 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -167,3 +167,13 @@ void sclp_memory_setup(void)
 
 	mem_init(ram_size);
 }
+
+uint64_t get_ram_size(void)
+{
+	return ram_size;
+}
+
+uint64_t get_max_ram_size(void)
+{
+	return max_ram_size;
+}
-- 
2.7.4

