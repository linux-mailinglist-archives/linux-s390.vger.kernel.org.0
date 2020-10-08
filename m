Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D876F286EE9
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 09:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJHHAG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Oct 2020 03:00:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29796 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgJHHAF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 03:00:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0986WS4n150271
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 03:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cXdK/V56YYTtKfh99DXpIcx/cCNU8os2UURptOfk94Q=;
 b=hhrbPFpmh0xzALvEhhW6Gjbw1qLCsh0GkvLMvScTFHQnLvdCAdqpMhJFTSgreeNX5Suu
 RGnlyIFkmAgD+Ygyio6Q8XOSgkZF1C4BqsmdWXNyfy6bTBx8o1nn3qYM4VJRkq6V+u0G
 C0tIcdhfRKgxrpZDlAYSrzZjP90zuN+HGtrLO+cPAHKsfw1erJxwrL+vNc98WHXr8o3O
 7s4uKQwEQ8KA+77uEZexkXHoU1n4HLnMPCPjbxvI6HVe8DEens5YDucAzMz3OLBn/aIK
 4s6D8nHam8eNGakdKCZ9ah08r/y27pxCGeqKuCfPq3QykdbrVn5fdYxwdX+XiAmHdyqi hA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341wk3gp8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 03:00:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0986sArZ030161
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 07:00:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx82mmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 07:00:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0986xxFi32965030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 06:59:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01E2B42045;
        Thu,  8 Oct 2020 06:59:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2EC742041;
        Thu,  8 Oct 2020 06:59:58 +0000 (GMT)
Received: from funtu.home (unknown [9.171.24.71])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Oct 2020 06:59:58 +0000 (GMT)
Subject: Re: [s390:features 73/81] drivers/s390/crypto/ap_queue.c:201:18:
 warning: format specifies type 'unsigned char' but the argument has type
 'int'
To:     linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <202010080727.HGqasHVn-lkp@intel.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
Date:   Thu, 8 Oct 2020 09:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010080727.HGqasHVn-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_03:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=921 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 08.10.20 01:41, kernel test robot wrote:
> 2ea2a6099ae3d1708f90f43c81a98cba3d4bb74c [73/81] s390/ap: add error response code field for ap queue devices

Fixed ... but why do these warnings not appear with normal build or with C=1 build ?

Maybe there is some pragma needed somewhere at where the debug feature printfs expand to ?

drivers/s390/crypto/ap_debug.h:26:47: note: expanded from macro 'AP_DBF_WARN'
           debug_sprintf_event(ap_dbf_info, DBF_WARN, ##__VA_ARGS__)

