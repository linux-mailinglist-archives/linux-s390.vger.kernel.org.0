Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032F12870C0
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJHIee (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Oct 2020 04:34:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgJHIee (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 04:34:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0988WJ36132995
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 04:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=pgcMEsCI7CPN3ZKLvKYad14eRY5N49orirt5o3zAxNc=;
 b=ByycxSvuz7Ezdm9+3bo/vCQctrYl4OnfWWdxebVDOzUHHk+pr+HA2j+LXE1nkyP+NFIs
 Y8R8XgXOf4lzGK55CXhl0uSM7ama18H/kkiI6Qx8zbiYyFNWxiOnfGZvTTJ8rjjf24po
 Xm+cYWG6vjwrOkaiEuXWIvNKlJ16B8PDT4V6fOdwgzSCVBDVc4OkWye0jmpK2f4/BdSt
 BpPKLckHsHS3q2S2L8hsn7CVttUl6hWXs2teKdNCFnWs2zbhUfgVgHnDaEIJBNQjKW6M
 m4GHLHz0E+sSGiumBI1O+Q0VQaCE0ZfsJiWKcTf7KT+08d6nETBpr2aKY5pVoEbvS/is bA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341y3rrf1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 04:34:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0988Wp4s028058
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 08:34:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh540a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 08:34:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0988YSqG30736870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 08:34:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55ED94C04E;
        Thu,  8 Oct 2020 08:34:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4794C044;
        Thu,  8 Oct 2020 08:34:28 +0000 (GMT)
Received: from localhost (unknown [9.145.52.142])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 08:34:28 +0000 (GMT)
Date:   Thu, 8 Oct 2020 10:34:26 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [s390:features 73/81] drivers/s390/crypto/ap_queue.c:201:18:
 warning: format specifies type 'unsigned char' but the argument has type
 'int'
Message-ID: <your-ad-here.call-01602146066-ext-5611@work.hours>
References: <202010080727.HGqasHVn-lkp@intel.com>
 <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_04:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 08, 2020 at 09:00:00AM +0200, Harald Freudenberger wrote:
> 
> On 08.10.20 01:41, kernel test robot wrote:
> > 2ea2a6099ae3d1708f90f43c81a98cba3d4bb74c [73/81] s390/ap: add error response code field for ap queue devices
> 
> Fixed ... but why do these warnings not appear with normal build or with C=1 build ?
> 
> Maybe there is some pragma needed somewhere at where the debug feature printfs expand to ?
> 
> drivers/s390/crypto/ap_debug.h:26:47: note: expanded from macro 'AP_DBF_WARN'
>            debug_sprintf_event(ap_dbf_info, DBF_WARN, ##__VA_ARGS__)

It seems to be the same for printk as well.

Variable function arguments which are passed via ... and of smaller
sizes then int are promoted to ints. It's called "default argument
promotion". So, its not like your code would crash or print garbage
if you use "%hhu" format and pass int or use "%d" and pass unsigned
char. It looks like gcc simply does not complain about such things,
while clang does.
