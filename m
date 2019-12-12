Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55811D8AA
	for <lists+linux-s390@lfdr.de>; Thu, 12 Dec 2019 22:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfLLVgS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Dec 2019 16:36:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731151AbfLLVgR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 16:36:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCLYH81095736
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 16:36:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wuq3wnjvn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 16:36:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 12 Dec 2019 21:36:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 21:36:12 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCLaAgL45940772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 21:36:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B71594C044;
        Thu, 12 Dec 2019 21:36:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A5CE4C040;
        Thu, 12 Dec 2019 21:36:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 21:36:10 +0000 (GMT)
From:   Karsten Graul <kgraul@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, raspl@linux.ibm.com,
        ubraun@linux.ibm.com
Subject: [PATCH net] net/smc: add fallback check to connect()
Date:   Thu, 12 Dec 2019 22:35:58 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19121221-0016-0000-0000-000002D43F0F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121221-0017-0000-0000-000033366780
Message-Id: <20191212213558.10564-1-kgraul@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120165
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

FASTOPEN setsockopt() or sendmsg() may switch the SMC socket to fallback
mode. Once fallback mode is active, the native TCP socket functions are
called. Nevertheless there is a small race window, when FASTOPEN
setsockopt/sendmsg runs in parallel to a connect(), and switch the
socket into fallback mode before connect() takes the sock lock.
Make sure the SMC-specific connect setup is omitted in this case.

This way a syzbot-reported refcount problem is fixed, triggered by
different threads running non-blocking connect() and FASTOPEN_KEY
setsockopt.

Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com
Fixes: 6d6dd528d5af ("net/smc: fix refcount non-blocking connect() -part 2")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b997072c72e5..cee5bf4a9bb9 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -857,6 +857,8 @@ static int smc_connect(struct socket *sock, struct sockaddr *addr,
 		goto out;
 
 	sock_hold(&smc->sk); /* sock put in passive closing */
+	if (smc->use_fallback)
+		goto out;
 	if (flags & O_NONBLOCK) {
 		if (schedule_work(&smc->connect_work))
 			smc->connect_nonblock = 1;
@@ -1721,8 +1723,6 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		sk->sk_err = smc->clcsock->sk->sk_err;
 		sk->sk_error_report(sk);
 	}
-	if (rc)
-		return rc;
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
@@ -1730,6 +1730,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		return -EFAULT;
 
 	lock_sock(sk);
+	if (rc || smc->use_fallback)
+		goto out;
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_FASTOPEN:
@@ -1741,15 +1743,14 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 			smc_switch_to_fallback(smc);
 			smc->fallback_rsn = SMC_CLC_DECL_OPTUNSUPP;
 		} else {
-			if (!smc->use_fallback)
-				rc = -EINVAL;
+			rc = -EINVAL;
 		}
 		break;
 	case TCP_NODELAY:
 		if (sk->sk_state != SMC_INIT &&
 		    sk->sk_state != SMC_LISTEN &&
 		    sk->sk_state != SMC_CLOSED) {
-			if (val && !smc->use_fallback)
+			if (val)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
@@ -1758,7 +1759,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		if (sk->sk_state != SMC_INIT &&
 		    sk->sk_state != SMC_LISTEN &&
 		    sk->sk_state != SMC_CLOSED) {
-			if (!val && !smc->use_fallback)
+			if (!val)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
@@ -1769,6 +1770,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	default:
 		break;
 	}
+out:
 	release_sock(sk);
 
 	return rc;
-- 
2.21.0

