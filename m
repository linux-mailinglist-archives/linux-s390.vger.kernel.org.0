Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4676ED15
	for <lists+linux-s390@lfdr.de>; Thu,  3 Aug 2023 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjHCOqp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Aug 2023 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbjHCOqf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Aug 2023 10:46:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8277619B9;
        Thu,  3 Aug 2023 07:46:32 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Eg8JZ011669;
        Thu, 3 Aug 2023 14:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=avuefi9Jf8+2a1NB7rc28/ORuP+YUHSjQ/Bxn8++A4s=;
 b=i/DWsOZEHgsDxsvqQcqPcuaAx9FdNP2G4+i/pXZJY4nRIaa4Tqpk3C2RvSXMojwt+8i8
 LVXq/Soc5oEwXVJV1ocgVfb+g0roqXlOPG/JxYfLlQirOsbW1nvNNGogEZzNV+q4Bhm/
 8yQkbcX3ssnz8TNuYlwCoTNXnd9FBXNl8kuYidaNrG5OxI1gl4MVeNTOr0KT0+MNzawp
 IFNTSi4q93ON+gcdQsBeZH7hRwadQVTRUkCFx3iS+XsekKlI9bwrIaJFVo7OBRyiKifd
 pAAWw9dy1POhCzcQjUgDrRAUTQhDvtjZBn7nbgxzynaLjM21iZb635mQ6ZbntgC6fzN7 IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8e7wr591-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:29 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373EgMkE012742;
        Thu, 3 Aug 2023 14:46:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8e7wr587-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373DwmD9015480;
        Thu, 3 Aug 2023 14:46:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3ne8qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373Ek8BM61538602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 14:46:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 050A420040;
        Thu,  3 Aug 2023 14:46:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9045020043;
        Thu,  3 Aug 2023 14:46:07 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 14:46:07 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net/smc: Use correct buffer sizes when switching between TCP and SMC
Date:   Thu,  3 Aug 2023 16:46:05 +0200
Message-ID: <20230803144605.477903-3-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803144605.477903-1-gbayer@linux.ibm.com>
References: <20230803144605.477903-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2tMWBT83Fm1T3Qgq0ZgI2Do9MbS_gGc
X-Proofpoint-ORIG-GUID: X53ZC6hFi7PrQEOgHQ0QVes4swtu3Ejv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Tuning of the effective buffer size through setsockopts was working for
SMC traffic only but not for TCP fall-back connections even before
commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
make them tunable"). That change made it apparent that TCP fall-back
connections would use net.smc.[rw]mem as buffer size instead of
net.ipv4_tcp_[rw]mem.

Amend the code that copies attributes between the (TCP) clcsock and the
SMC socket and adjust buffer sizes appropriately:
- Copy over sk_userlocks so that both sockets agree on whether tuning
  via setsockopt is active.
- When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
  setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
- Likewise, use either values from setsockopt or from sysctl for SMC
  (duplicated) on successful SMC connect.

In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
is taken care of by the attribute copy.

Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c | 73 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 1fcf1e42474a..385e86bd6bdf 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -436,13 +436,60 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
 	return rc;
 }
 
+/* copy only relevant settings and flags of SOL_SOCKET level from smc to
+ * clc socket (since smc is not called for these options from net/core)
+ */
+
+#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
+			     (1UL << SOCK_KEEPOPEN) | \
+			     (1UL << SOCK_LINGER) | \
+			     (1UL << SOCK_BROADCAST) | \
+			     (1UL << SOCK_TIMESTAMP) | \
+			     (1UL << SOCK_DBG) | \
+			     (1UL << SOCK_RCVTSTAMP) | \
+			     (1UL << SOCK_RCVTSTAMPNS) | \
+			     (1UL << SOCK_LOCALROUTE) | \
+			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
+			     (1UL << SOCK_RXQ_OVFL) | \
+			     (1UL << SOCK_WIFI_STATUS) | \
+			     (1UL << SOCK_NOFCS) | \
+			     (1UL << SOCK_FILTER_LOCKED) | \
+			     (1UL << SOCK_TSTAMP_NEW))
+
+/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
+static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
+				     unsigned long mask)
+{
+	struct net *nnet = sock_net(nsk);
+
+	nsk->sk_userlocks = osk->sk_userlocks;
+	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
+		nsk->sk_sndbuf = osk->sk_sndbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_sndbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
+	}
+	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
+		nsk->sk_rcvbuf = osk->sk_rcvbuf;
+	} else {
+		if (mask == SK_FLAGS_SMC_TO_CLC)
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
+		else
+			WRITE_ONCE(nsk->sk_rcvbuf,
+				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
+	}
+}
+
 static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 				   unsigned long mask)
 {
 	/* options we don't get control via setsockopt for */
 	nsk->sk_type = osk->sk_type;
-	nsk->sk_sndbuf = osk->sk_sndbuf;
-	nsk->sk_rcvbuf = osk->sk_rcvbuf;
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = osk->sk_mark;
@@ -453,26 +500,10 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 
 	nsk->sk_flags &= ~mask;
 	nsk->sk_flags |= osk->sk_flags & mask;
+
+	smc_adjust_sock_bufsizes(nsk, osk, mask);
 }
 
-#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
-			     (1UL << SOCK_KEEPOPEN) | \
-			     (1UL << SOCK_LINGER) | \
-			     (1UL << SOCK_BROADCAST) | \
-			     (1UL << SOCK_TIMESTAMP) | \
-			     (1UL << SOCK_DBG) | \
-			     (1UL << SOCK_RCVTSTAMP) | \
-			     (1UL << SOCK_RCVTSTAMPNS) | \
-			     (1UL << SOCK_LOCALROUTE) | \
-			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
-			     (1UL << SOCK_RXQ_OVFL) | \
-			     (1UL << SOCK_WIFI_STATUS) | \
-			     (1UL << SOCK_NOFCS) | \
-			     (1UL << SOCK_FILTER_LOCKED) | \
-			     (1UL << SOCK_TSTAMP_NEW))
-/* copy only relevant settings and flags of SOL_SOCKET level from smc to
- * clc socket (since smc is not called for these options from net/core)
- */
 static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 {
 	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
@@ -2479,8 +2510,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
-		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
-		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
 		sock_hold(&new_smc->sk); /* sock_put in passive closing */
 		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
 			sock_put(&new_smc->sk);
-- 
2.41.0

