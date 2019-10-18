Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEB7DC45C
	for <lists+linux-s390@lfdr.de>; Fri, 18 Oct 2019 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409977AbfJRMGn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Oct 2019 08:06:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409976AbfJRMGm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 18 Oct 2019 08:06:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IBwXFl002090
        for <linux-s390@vger.kernel.org>; Fri, 18 Oct 2019 08:06:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqcqbgy5n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 18 Oct 2019 08:06:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Fri, 18 Oct 2019 13:06:38 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 13:06:37 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9IC63vu40435976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 12:06:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72ABA4203F;
        Fri, 18 Oct 2019 12:06:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B7C42042;
        Fri, 18 Oct 2019 12:06:35 +0000 (GMT)
Received: from [9.152.214.37] (unknown [9.152.214.37])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Oct 2019 12:06:34 +0000 (GMT)
Subject: Re: memory leaks in dasd_eckd_check_characteristics() error paths
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1570044801.5576.262.camel@lca.pw>
 <6f5584d5-755c-e416-52da-3cb99c69adaf@linux.ibm.com>
 <1571234974.5937.53.camel@lca.pw>
 <ddc3fb26-2286-de78-70dd-ef0f62bfd6c0@linux.ibm.com>
 <1571239578.5937.62.camel@lca.pw>
 <3e03a30c-f0c8-2941-7545-fcf609d77cb0@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sth@linux.ibm.com; keydata=
 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
 cH4TNHyhiR0KAbxE8qKx3Jc=
Date:   Fri, 18 Oct 2019 14:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3e03a30c-f0c8-2941-7545-fcf609d77cb0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101812-0028-0000-0000-000003AB44C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101812-0029-0000-0000-0000246D6594
Message-Id: <8a97238f-deaf-f301-a8f3-6f707be83c5d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=60 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180116
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16.10.19 17:28, Stefan Haberland wrote:
> On 16.10.19 17:26, Qian Cai wrote:
>> On Wed, 2019-10-16 at 16:56 +0200, Stefan Haberland wrote:
>>> On 16.10.19 16:09, Qian Cai wrote:
>>>> On Wed, 2019-10-16 at 15:29 +0200, Stefan Haberland wrote:
>>>>> Hi,
>>>>>
>>>>> thanks for reporting this.
>>>>>
>>>>> On 02.10.19 21:33, Qian Cai wrote:
>>>>>> For some reasons, dasd_eckd_check_characteristics() received -ENOMEM and then
>>>>>> dasd_generic_set_online() emits this message,
>>>>>>
>>>>>> dasd: 0.0.0122 Setting the DASD online with discipline ECKD failed with rc=-12
>>>>>>
>>>>>> After that, there are several memory leaks below. There are "config_data" and
>>>>>> then stored as,
>>>>>>
>>>>>> /* store per path conf_data */
>>>>>> device->path[pos].conf_data = conf_data;
>>>>>>
>>>>>> When it processes the error path in  dasd_generic_set_online(), it calls
>>>>>> dasd_delete_device() which nuke the whole "struct dasd_device" without freeing
>>>>>> the device->path[].conf_data first. 
>>>>> Usually dasd_delete_device() calls dasd_generic_free_discipline() which
>>>>> takes care of
>>>>> the device->path[].conf_data in dasd_eckd_uncheck_device().
>>>>> From a first look this looks sane.
>>>>>
>>>>> So I need to spend a closer look if this does not happen correctly here.
>>>> When dasd_eckd_check_characteristics() failed here,
>>>>
>>>> 	if (!private) {
>>>> 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
>>>> 		if (!private) {
>>>> 			dev_warn(&device->cdev->dev,
>>>> 				 "Allocating memory for private DASD data "
>>>> 				 "failed\n");
>>>> 			return -ENOMEM;
>>>> 		}
>>>> 		device->private = private;
>>>>
>>>> The device->private is NULL.
>>>>
>>>> Then, in dasd_eckd_uncheck_device(), it will return immediately.
>>>>
>>>> 	if (!private)
>>>> 		return;
>>> Yes but in this case there is no per_path configuration data stored.
>>> This is done after the private structure is allocated successfully.
>> Yes, you are right. It has been a while so I must lost a bit memory. Actually,
>> it looks like in dasd_eckd_check_characteristic() that device->private is set to
>> NULL from this path,
>>
>> 	/* Read Configuration Data */
>> 	rc = dasd_eckd_read_conf(device);
>> 	if (rc)
>> 		goto out_err1;
>>
>> out_err1:
>> 	kfree(private->conf_data);
>> 	kfree(device->private);
>> 	device->private = NULL;
>> 	return rc;
>>
>> because dasd_eckd_read_conf() returns -ENOMEM and calls,
>>
>> out_error:
>> 	kfree(rcd_buf);
>> 	*rcd_buffer = NULL;
>> 	*rcd_buffer_size = 0;
>> 	return ret;
>>
>> It will only free its own config_data in one operational path, but there could
>> has already allocated in earlier paths in dasd_eckd_read_conf() without any
>> rollback and calls return,
>>
>> 	for (lpm = 0x80; lpm; lpm>>= 1) {
>> 		if (!(lpm & opm))
>> 			continue;
>> 		rc = dasd_eckd_read_conf_lpm(device, &conf_data,
>> 					     &conf_len, lpm);
>> 		if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
>> 			DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
>> 					"Read configuration data returned "
>> 					"error %d", rc);
>> 			return rc;
>> 		}
>>
>> Later, dasd_eckd_uncheck_device() see private->device is NULL without cleaning
>> up. Does it make sense?
> Yes, this looks like an error path not handling this correctly.
>

I will provide a patch for this. Most likely I will cover this in the
error handling of the function.
Thanks again for reporting.

Regards,
Stefan

