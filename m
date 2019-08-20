Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A945961B5
	for <lists+linux-s390@lfdr.de>; Tue, 20 Aug 2019 15:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfHTN5E (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Aug 2019 09:57:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729203AbfHTN5E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 09:57:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KDv1OA033413
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:57:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ughxq8tdq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:57:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 14:56:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 14:56:48 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KDumOB57016530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 13:56:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E387B4203F;
        Tue, 20 Aug 2019 13:56:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B015C42042;
        Tue, 20 Aug 2019 13:56:47 +0000 (GMT)
Received: from [9.152.222.35] (unknown [9.152.222.35])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 13:56:47 +0000 (GMT)
Subject: Re: [bug report] s390/qeth: streamline SNMP cmd code
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-s390@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ursula Braun <ubraun@linux.ibm.com>
References: <20190820110504.GA1847@mwanda>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Date:   Tue, 20 Aug 2019 15:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820110504.GA1847@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082013-0008-0000-0000-0000030B120A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082013-0009-0000-0000-00004A293987
Message-Id: <95addda5-aa7e-32f3-0665-42fb7847788a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200143
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20.08.19 13:05, Dan Carpenter wrote:
> [  Kees, could we make copy_from_user() just fail if size is more than
>    INT_MAX? ]
> 
> Hello Julian Wiedmann,
> 

Heya Dan - thanks! Agreed, that looks wrong. I'll put together a fix...


> The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
> Jun 27, 2019, leads to the following static checker warning:
> 
> 	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
> 	error: check that 'req_len' is capped
> 
> drivers/s390/net/qeth_core_main.c
>   4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>   4356  {
>   4357          struct qeth_snmp_ureq __user *ureq;
>   4358          struct qeth_cmd_buffer *iob;
>   4359          unsigned int req_len;
>   4360          struct qeth_arp_query_info qinfo = {0, };
>   4361          int rc = 0;
>   4362  
>   4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
>   4364  
>   4365          if (IS_VM_NIC(card))
>   4366                  return -EOPNOTSUPP;
>   4367  
>   4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
>   4369              IS_LAYER3(card))
>   4370                  return -EOPNOTSUPP;
>   4371  
>   4372          ureq = (struct qeth_snmp_ureq __user *) udata;
>   4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
>   4374              get_user(req_len, &ureq->hdr.req_len))
>   4375                  return -EFAULT;
>   4376  
>   4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
> 
> The problem is that qeth_get_adapter_cmd() doesn't guard against integer
> overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
> data)).
> 
>   4378          if (!iob)
>   4379                  return -ENOMEM;
>   4380  
>   4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
>   4382                             &ureq->cmd, req_len)) {
> 
> So then this copy_from_user() could overflow.  The original code had a
> similar problem but it only affect 32 bit systems.  I'm not sure what is
> a good upper bound for req_len.
> 
>   4383                  qeth_put_cmd(iob);
>   4384                  return -EFAULT;
>   4385          }
>   4386  
>   4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
> 
> regards,
> dan carpenter
> 

