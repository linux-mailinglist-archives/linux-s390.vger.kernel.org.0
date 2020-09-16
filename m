Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1426C834
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgIPSnQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Sep 2020 14:43:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIPSnL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Sep 2020 14:43:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEiTfe096117;
        Wed, 16 Sep 2020 14:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tMiXLyizHE+NUvZ94J3Emvlnh6CXKhE0yuXhJ40op3M=;
 b=ZcldbcU/Cn3twZb4w5Y6+ny/7FCUqrvczg7m80oohzeg5mh15hyMhFYZJ6FOJPLxG874
 WPB74SC4T2PEwElPT6egsiSxWBRetwYO41ju2ESYLvuCXpSZn0BrTXKuW3diF1+VPlSK
 zmyyls4odDP2oHXr2PnpiMQQR+HEfdJdJnH2JOTVi7Tqkl9H106cXfYf7nqL2aT3Wm0e
 C3zfmby4HqwIBOeaJyiiY0CjE0eceLhakI4DoxYfhc6h9cHl8r56xU8QmOf0xuxaDHFJ
 SOlinyTuBLV1cdnO96ZNWn8TDFb2NIH4Vc0bjVv45jpI+jfh+X+SD1NpfubLhwgQCtFB Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrr3jq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 14:45:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEe1OT172207;
        Wed, 16 Sep 2020 14:43:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33khpkhhxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:43:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08GEhs76009475;
        Wed, 16 Sep 2020 14:43:54 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 14:43:53 +0000
Date:   Wed, 16 Sep 2020 17:43:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ubraun@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: [bug report] net/smc: dynamic allocation of CLC proposal buffer
Message-ID: <20200916144349.GA766931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=10
 mlxlogscore=991 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=10
 clxscore=1015 mlxlogscore=985 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160112
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Ursula Braun,

The patch 6bb14e48ee8d: "net/smc: dynamic allocation of CLC proposal
buffer" from Sep 10, 2020, leads to the following static checker
warning:

	net/smc/af_smc.c:1390 smc_listen_work()
	warn: 'buf' was already freed.

net/smc/af_smc.c
  1363  
  1364          /* receive SMC Confirm CLC message */
  1365          rc = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
  1366                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
  1367          if (rc) {
  1368                  if (!ism_supported)
  1369                          goto out_unlock;
  1370                  goto out_decl;
  1371          }
  1372  
  1373          /* finish worker */
  1374          kfree(buf);
                ^^^^^^^^^^
freed.

  1375          if (!ism_supported) {
  1376                  rc = smc_listen_rdma_finish(new_smc, &cclc,
  1377                                              ini.first_contact_local);
  1378                  if (rc)
  1379                          goto out_unlock;
                                ^^^^^^^^^^^^^^^

  1380                  mutex_unlock(&smc_server_lgr_pending);
  1381          }
  1382          smc_conn_save_peer_info(new_smc, &cclc);
  1383          smc_listen_out_connected(new_smc);
  1384          return;
  1385  
  1386  out_unlock:
  1387          mutex_unlock(&smc_server_lgr_pending);
  1388  out_decl:
  1389          smc_listen_decline(new_smc, rc, ini.first_contact_local);
  1390          kfree(buf);
                ^^^^^^^^^^
Double free.

  1391  }

regards,
dan carpenter
