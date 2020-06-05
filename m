Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8211EF234
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2020 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEHh0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 5 Jun 2020 03:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgFEHhY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 03:37:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0557VvuU130676;
        Fri, 5 Jun 2020 03:37:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31f9devjvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 03:37:23 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0557X7Co134848;
        Fri, 5 Jun 2020 03:37:22 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31f9devjv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 03:37:22 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0557ZhNV013289;
        Fri, 5 Jun 2020 07:37:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 31bf47cqbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 07:37:20 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0557bItg37028084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 07:37:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 536864C059;
        Fri,  5 Jun 2020 07:37:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E9264C052;
        Fri,  5 Jun 2020 07:37:18 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.68.25])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 07:37:17 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v7 09/12] s390x: css: msch, enable test
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-10-git-send-email-pmorel@linux.ibm.com>
 <20200527114239.65fa9473.cohuck@redhat.com>
 <65501204-f6f3-7800-e382-63ccad77ca38@linux.ibm.com>
 <20200604152945.4cb433bd.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ea12784c-df16-db4b-dd9c-b5b77bcbe9f9@linux.ibm.com>
Date:   Fri, 5 Jun 2020 09:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604152945.4cb433bd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_01:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050053
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2020-06-04 15:29, Cornelia Huck wrote:
> On Thu, 4 Jun 2020 14:46:05 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-05-27 11:42, Cornelia Huck wrote:
>>> On Mon, 18 May 2020 18:07:28 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> A second step when testing the channel subsystem is to prepare a channel
>>>> for use.
>>>> This includes:
>>>> - Get the current subchannel Information Block (SCHIB) using STSCH
>>>> - Update it in memory to set the ENABLE bit
>>>> - Tell the CSS that the SCHIB has been modified using MSCH
>>>> - Get the SCHIB from the CSS again to verify that the subchannel is
>>>>     enabled.
>>>> - If the subchannel is not enabled retry a predefined retries count.
>>>>
>>>> This tests the MSCH instruction to enable a channel succesfuly.
>>>> This is NOT a routine to really enable the channel, no retry is done,
>>>> in case of error, a report is made.
>>>
>>> Hm... so you retry if the subchannel is not enabled after cc 0, but you
>>> don't retry if the cc indicates busy/status pending? Makes sense, as we
>>> don't expect the subchannel to be busy, but a more precise note in the
>>> patch description would be good :)
>>
>> OK, I add something like
>> "
>> - If the command succeed but subchannel is not enabled retry a
> 
> s/succeed/succeeds/ :)
> 
>>     predefined retries count.
>> - If the command fails, report the failure and do not retry, even
>>     if cc indicates a busy/status as we do not expect this.
> 
> "indicates busy/status pending" ?
> 
>> "
> 
done, thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
