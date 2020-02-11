Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691CC158C8C
	for <lists+linux-s390@lfdr.de>; Tue, 11 Feb 2020 11:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgBKKT0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 11 Feb 2020 05:19:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728216AbgBKKT0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 05:19:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BAEHoI140128
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:19:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ubrg005-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 05:19:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 11 Feb 2020 10:19:23 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Feb 2020 10:19:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BAJIDL47317152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 10:19:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3038142045;
        Tue, 11 Feb 2020 10:19:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E6F4203F;
        Tue, 11 Feb 2020 10:19:17 +0000 (GMT)
Received: from [9.152.212.29] (unknown [9.152.212.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 10:19:17 +0000 (GMT)
Subject: Re: [PATCH 1/1] cio_ignore_proc_seq_next should increase position
 index
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <d44c53a7-9bc1-15c7-6d4a-0c10cb9dffce@virtuozzo.com>
 <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 11 Feb 2020 11:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <51ac7c33-ea7d-d780-c9de-4858af5e5f18@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021110-0020-0000-0000-000003A915EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021110-0021-0000-0000-00002200F535
Message-Id: <2d65a0ec-2d41-9efa-b2fb-1d6a93aa4800@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_02:2020-02-10,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110076
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07.02.2020 14:13, Christian Borntraeger wrote:
> 
> 
> On 24.01.20 06:48, Vasily Averin wrote:
>> if seq_file .next fuction does not change position index,
>> read after some lseek can generate unexpected output.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  drivers/s390/cio/blacklist.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
>> index 2a3f874..9cebff8 100644
>> --- a/drivers/s390/cio/blacklist.c
>> +++ b/drivers/s390/cio/blacklist.c
>> @@ -303,8 +303,10 @@ struct ccwdev_iter {
>>  cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
>>  {
>>  	struct ccwdev_iter *iter;
>> +	loff_t p = *offset;
>>  
>> -	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
>> +	(*offset)++;
>> +	if (p >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
>>  		return NULL;
>>  	iter = it;
>>  	if (iter->devno == __MAX_SUBCHANNEL) {
>> @@ -314,7 +316,6 @@ struct ccwdev_iter {
>>  			return NULL;
>>  	} else
>>  		iter->devno++;
>> -	(*offset)++;
>>  	return iter;
>>  }
>>  
>>
> 
> I guess this fixes one aspect:
> "dd: /proc/cio_ignore: cannot skip to specified offset"
> is now gone. So I am tempted to apply this. 
> 
> but this code is still fishy:
> 
> $ cat /proc/cio_ignore 
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ffff
> $ dd if=/proc/cio_ignore status=none
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ffff
> $ dd if=/proc/cio_ignore status=none bs=10
> 0.0.fe00-0.0.fefe
> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
> $ dd if=/proc/cio_ignore status=none bs=10 skip=1
> .0.fefe
> 0.0.ff00-0.0.ff01-0.0.ff02-0.0.ff03-0.0.ff04-0.0.ff05-0.0.ff06-0.0.ff07-0.0.ff08-0.0.ffff
> 
> 
> Peter, any opinions on this?

A correct implementation of a file read operation must result in the
same data being read independently of whether the file is read in one
go, or if it is read byte-by-byte.

It seems that the current cio_ignore seq-file implementation doesn't
meet that requirement. I don't think that this patch series is the best
way to address this problem though.

My suggestion would be to apply this patch set as is, and then I'll take
the to-do to fix this seq file implementation at a later time.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

