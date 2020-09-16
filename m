Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED6526CE19
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIPVJb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Sep 2020 17:09:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgIPPzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GFhrQX177122;
        Wed, 16 Sep 2020 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zndgdey+IvCJP/FPfWXQZhQ1FurUGKyKPBc72TBUW14=;
 b=giDi3gvE4kSXW7AwPs8uWz2P6iYmXSKyq2Wsf8X8OTm09A7+18xuvoNWY+J1s2nFTnKq
 wXB+CJEFjBlKqHuTCEEaIl5yfP2+mptHC3Oks6EjrX0kQ6y3UR9vAYmtahJRTPYxrFtX
 J++WTqbBxstJul7263bABmkHiigkr6if4bvULtntPK4fyH9UdWORf9ExELSiIgnyu4qj
 CTcxk6uAjcod8oz3byAYgT2ySltmOXN50JPJNb+LZLE01oKGqbSbae2s3tNGgRG0wAnV
 i4RO9sHoczRibv1Ws1+/5fVb8kJTGrfaUtBXN5aB1xl6kazCzkAThhaZCD2l61Rbw4pC Kg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33knkwgbqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:55:33 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GFgP2g031968;
        Wed, 16 Sep 2020 15:55:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esgsyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 15:55:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GFrsZg26280446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 15:53:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B53845204E;
        Wed, 16 Sep 2020 15:55:28 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.145.69.186])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A46A52050;
        Wed, 16 Sep 2020 15:55:28 +0000 (GMT)
Subject: Re: [bug report] net/smc: dynamic allocation of CLC proposal buffer
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>
References: <20200916144349.GA766931@mwanda>
From:   Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <486c8ade-033e-ca2e-4ec7-122e295392cf@linux.ibm.com>
Date:   Wed, 16 Sep 2020 17:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916144349.GA766931@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_10:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160113
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 9/16/20 4:43 PM, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch 6bb14e48ee8d: "net/smc: dynamic allocation of CLC proposal
> buffer" from Sep 10, 2020, leads to the following static checker
> warning:
> 
> 	net/smc/af_smc.c:1390 smc_listen_work()
> 	warn: 'buf' was already freed.
> 
> net/smc/af_smc.c
>   1363  
>   1364          /* receive SMC Confirm CLC message */
>   1365          rc = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
>   1366                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
>   1367          if (rc) {
>   1368                  if (!ism_supported)
>   1369                          goto out_unlock;
>   1370                  goto out_decl;
>   1371          }
>   1372  
>   1373          /* finish worker */
>   1374          kfree(buf);
>                 ^^^^^^^^^^
> freed.
> 
>   1375          if (!ism_supported) {
>   1376                  rc = smc_listen_rdma_finish(new_smc, &cclc,
>   1377                                              ini.first_contact_local);
>   1378                  if (rc)
>   1379                          goto out_unlock;
>                                 ^^^^^^^^^^^^^^^
> 
>   1380                  mutex_unlock(&smc_server_lgr_pending);
>   1381          }
>   1382          smc_conn_save_peer_info(new_smc, &cclc);
>   1383          smc_listen_out_connected(new_smc);
>   1384          return;
>   1385  
>   1386  out_unlock:
>   1387          mutex_unlock(&smc_server_lgr_pending);
>   1388  out_decl:
>   1389          smc_listen_decline(new_smc, rc, ini.first_contact_local);
>   1390          kfree(buf);
>                 ^^^^^^^^^^
> Double free.
> 
>   1391  }
> 
> regards,
> dan carpenter
> 

Thanks Dan for reporting this issue in the net-next kernel!

Our plan is to come up with this follow-on patch:


net/smc: fix double kfree in smc_listen_work()

If smc_listen_rmda_finish() returns with an error, the storage
addressed by "buf" is freed a second time.
Move freeing in case of success after the smc_listen_rdma_finish()
call.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 6bb14e48ee8d ("net/smc: dynamic allocation of CLC proposal buffer")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1371,7 +1371,6 @@ static void smc_listen_work(struct work_
 	}
 
 	/* finish worker */
-	kfree(buf);
 	if (!ism_supported) {
 		rc = smc_listen_rdma_finish(new_smc, &cclc,
 					    ini.first_contact_local);
@@ -1380,6 +1379,7 @@ static void smc_listen_work(struct work_
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
+	kfree(buf);
 	smc_listen_out_connected(new_smc);
 	return;


Regards, Ursula Braun




