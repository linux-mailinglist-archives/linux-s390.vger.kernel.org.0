Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077EE26B28C
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgIOWtW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 18:49:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgIOPny (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FFVnGT090166;
        Tue, 15 Sep 2020 11:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=jpqjLlCXWpKZ/xcPxu5166oB4NTBH1LeBGRQQrbum2E=;
 b=P3UxZaSUa/8ksk0tBnYAVyc7ChqpOEP6ne3ees+72eYKCsiCUEp3AvRalh/KHeD0N+ze
 v6lnyrxxSyapiF98JxN3srRzCHbob170kZ8ENQHMhztyQ07vILtcvzUbzK9el6i22eQO
 8+RU8mCyTKJYSkGC2TgHQw2Rvbfhag2JUdKrOWVz1ckf8mw2VpVceiqonnVvl4SFK1Sc
 a+MXe4RfqJXg4UznUK7QXX0HKtUxO/CGifZJ7NbTo++oUUwNOrYSF6RPHaVHT1V5b0V2
 2XxmzkTnKSq++5sfU8l13yPtMKbH1zMXQSBJOeJ+8kRJMqBDADAwZcvzcjmIopzKW4Ec tQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33k056rpsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:43:47 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FFPLOr032108;
        Tue, 15 Sep 2020 15:43:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 33gny81xgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 15:43:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FFhgDE27591116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 15:43:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD1EA405B;
        Tue, 15 Sep 2020 15:43:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10ACAA4054;
        Tue, 15 Sep 2020 15:43:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 15:43:42 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/4] s390/uaccess: implement HAVE_GET_KERNEL_NOFAULT support
Date:   Tue, 15 Sep 2020 17:43:39 +0200
Message-Id: <20200915154340.4215-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915154340.4215-1-hca@linux.ibm.com>
References: <20200915154340.4215-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=852
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uaccess.h | 111 ++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index f09444d6aeab..3ef424bca082 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -278,4 +278,115 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 int copy_to_user_real(void __user *dest, void *src, unsigned long count);
 void *s390_kernel_write(void *dst, const void *src, size_t size);
 
+#define HAVE_GET_KERNEL_NOFAULT
+
+int __put_kernel_bad(void) __attribute__((noreturn));
+
+#define __put_kernel_asm(val, to, insn)					\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"0:   " insn "  %2,%1\n"				\
+		"1:	xr	%0,%0\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%0,%3\n"				\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: "=d" (__rc), "+Q" (*(to))				\
+		: "d" (val), "K" (-EFAULT)				\
+		: "cc");						\
+	__rc;								\
+})
+
+#define __put_kernel_nofault(dst, src, type, err_label)                 \
+do {                                                                    \
+	u64 __x = (u64)(*((type *)(src)));				\
+	int __pk_err;							\
+									\
+	switch (sizeof(type)) {						\
+	case 1:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "stc"); \
+		break;							\
+	case 2:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "sth"); \
+		break;							\
+	case 4:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "st");	\
+		break;							\
+	case 8:								\
+		__pk_err = __put_kernel_asm(__x, (type *)(dst), "stg"); \
+		break;							\
+	default:							\
+		__pk_err = __put_kernel_bad();				\
+		break;							\
+	}								\
+	if (unlikely(__pk_err))						\
+		goto err_label;						\
+} while (0)
+
+int __get_kernel_bad(void) __attribute__((noreturn));
+
+#define __get_kernel_asm(val, from, insn)				\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"0:   " insn "  %1,%2\n"				\
+		"1:	xr	%0,%0\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%0,%3\n"				\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: "=d" (__rc), "+d" (val)				\
+		: "Q" (*(from)), "K" (-EFAULT)				\
+		: "cc");						\
+	__rc;								\
+})
+
+#define __get_kernel_nofault(dst, src, type, err_label)                 \
+do {                                                                    \
+	int __gk_err = -EFAULT;						\
+									\
+	switch (sizeof(type)) {						\
+	case 1: {							\
+		u8 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "ic");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 2: {							\
+		u16 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "lh");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 4: {							\
+		u32 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "l");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	case 8: {							\
+		u64 __x = 0;						\
+									\
+		__gk_err = __get_kernel_asm(__x, (type *)(src), "lg");	\
+		*((type *)(dst)) = (type)__x;				\
+		break;							\
+	};								\
+	default:							\
+		__gk_err = __get_kernel_bad();				\
+		break;							\
+	}								\
+	if (unlikely(__gk_err))						\
+		goto err_label;						\
+} while (0)
+
 #endif /* __S390_UACCESS_H */
-- 
2.17.1

