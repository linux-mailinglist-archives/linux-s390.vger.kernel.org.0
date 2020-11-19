Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B122B8CF8
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 09:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSIQp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 03:16:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgKSIQp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:16:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ85OqT080426;
        Thu, 19 Nov 2020 03:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UBfXcnas4LdjhXBaPPRy2wBNEm5NE9l5KXW753DIC9k=;
 b=Qhe0HeP3j2WizUldqP6r228MHxDag0IIoWo7w1DZKwrPIPLXLe0s3Ys/T0NWDFFZDXXx
 OLkmGU7RBtMPgIYURgcIhtRUSa/y1T13uncDek5HR/BXwJY4bW5fnZhDigC7de8YYNnI
 kzRh9hw+LvdKb3bI+jU0/Ws8ZBQmtgkEplJrmVsNk8/pfmcNG48J4bhqjMatzK1CYl3T
 NPKvgwK+5UxW858IxS09RY2GwlA2lEPYGcC+6YTqHF7gFdLnmoBF5FuWP9y4EikZtt0b
 2cV6z09A99XFIYfk8RlUBTZRuKCg5X8SRKsx9lD7Z+4fv6hfoTrXGl0TsbrnUgVu98LP Ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34wg5t76h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 03:16:34 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ8D7im016030;
        Thu, 19 Nov 2020 08:16:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34weby09sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 08:16:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ8GTOe64618976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 08:16:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 234365204F;
        Thu, 19 Nov 2020 08:16:29 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 950945204E;
        Thu, 19 Nov 2020 08:16:28 +0000 (GMT)
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
 <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
 <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <10c005bb-f590-d213-8e43-f3411248e79f@linux.ibm.com>
Date:   Thu, 19 Nov 2020 10:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201119081248.iyb2dxeazgm3fhyg@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_05:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=2 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190054
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19.11.20 10:12, Sebastian Andrzej Siewior wrote:
> On 2020-11-19 09:45:08 [+0200], Julian Wiedmann wrote:
>> On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
>>> The size of struct th_header is 8 byte and the size of struct th_sweep
>>> is 16 byte. The memory for is allocated, initialized, used and
>>> deallocated a few lines later.
>>>
>>> It is more efficient to avoid the allocation/free dance and keeping the
>>> variable on stack. Especially since the compiler is smart enough to not
>>> allocate the memory on stack but assign the values directly.
>>>
>>> Declare struct th_sweep/th_header on stack and initialize it to zero.
>>> Use the local variable instead of the pointer.
>>>
>>
>> Frankly, I'd much rather see us use the pointers that are returned from
>> skb_push() and skb_put(). No need for the on-stack & memcpy indirection.
> 
> You are aware that the compiler optimizes the on-stack memory away and
> you get the zero-init for free due to the way the assignment is made?
> There is no memcpy() in the resulting code.
> 
> Sebastian
> 

I am not worried about performance at all. Yet readability matters.
