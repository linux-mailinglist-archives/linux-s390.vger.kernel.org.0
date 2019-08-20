Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1654E95CD2
	for <lists+linux-s390@lfdr.de>; Tue, 20 Aug 2019 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfHTLFO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Aug 2019 07:05:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfHTLFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 07:05:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KB4BBt017434;
        Tue, 20 Aug 2019 11:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=RV3z3ihyQ137sp/s3Qs96uNnRjvEkaYmspdXVLfYp/k=;
 b=aJw22r2WddN2eb+POke/+GydMMEnKgtnQMKb+B8nOgkkoA2k1zw41kpEB/Xexmdxxo8h
 SD8lAPvwLBIk5615Z7k4sTl8oeK4JUpgAxg5pMPeNLwb5wrE0jphBiyNHoGWjaO6xGW4
 c9x+vTDh0drPSN0CB3kJgaDtRCx6tETBcCFF3v6AsjXEjz0ZtzVqsutPM/sQ7A6yfjCJ
 Unw3w4IxfECRgeLImPRJs1lCbKcFY0HBmCIsY2DOQhrgRWDwqe33bjcVSx9afchjlE2b
 Xk5Fg07P+/mbmCsPiLNaqdG6f9PeMhwP504jxUvc2qoAMzEH3nyZZkYPH0KNxrTi6SIm bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uea7qnh9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 11:05:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KB3biu183087;
        Tue, 20 Aug 2019 11:05:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ug1g93wjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 11:05:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7KB59kF008890;
        Tue, 20 Aug 2019 11:05:10 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Aug 2019 04:05:09 -0700
Date:   Tue, 20 Aug 2019 14:05:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jwi@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [bug report] s390/qeth: streamline SNMP cmd code
Message-ID: <20190820110504.GA1847@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908200116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908200116
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[  Kees, could we make copy_from_user() just fail if size is more than
   INT_MAX? ]

Hello Julian Wiedmann,

The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
Jun 27, 2019, leads to the following static checker warning:

	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
	error: check that 'req_len' is capped

drivers/s390/net/qeth_core_main.c
  4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
  4356  {
  4357          struct qeth_snmp_ureq __user *ureq;
  4358          struct qeth_cmd_buffer *iob;
  4359          unsigned int req_len;
  4360          struct qeth_arp_query_info qinfo = {0, };
  4361          int rc = 0;
  4362  
  4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
  4364  
  4365          if (IS_VM_NIC(card))
  4366                  return -EOPNOTSUPP;
  4367  
  4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
  4369              IS_LAYER3(card))
  4370                  return -EOPNOTSUPP;
  4371  
  4372          ureq = (struct qeth_snmp_ureq __user *) udata;
  4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
  4374              get_user(req_len, &ureq->hdr.req_len))
  4375                  return -EFAULT;
  4376  
  4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);

The problem is that qeth_get_adapter_cmd() doesn't guard against integer
overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
data)).

  4378          if (!iob)
  4379                  return -ENOMEM;
  4380  
  4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
  4382                             &ureq->cmd, req_len)) {

So then this copy_from_user() could overflow.  The original code had a
similar problem but it only affect 32 bit systems.  I'm not sure what is
a good upper bound for req_len.

  4383                  qeth_put_cmd(iob);
  4384                  return -EFAULT;
  4385          }
  4386  
  4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);

regards,
dan carpenter
