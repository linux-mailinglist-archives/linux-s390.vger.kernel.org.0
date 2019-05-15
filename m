Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9D1F699
	for <lists+linux-s390@lfdr.de>; Wed, 15 May 2019 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfEOOas (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 May 2019 10:30:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbfEOOas (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 May 2019 10:30:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FENFDe093398
        for <linux-s390@vger.kernel.org>; Wed, 15 May 2019 10:30:47 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sgjv0exsm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 May 2019 10:30:46 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <alifm@linux.ibm.com>;
        Wed, 15 May 2019 15:30:40 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 15:30:38 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FEUaDH8716672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 14:30:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B45B2C6063;
        Wed, 15 May 2019 14:30:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51FABC6066;
        Wed, 15 May 2019 14:30:36 +0000 (GMT)
Received: from [9.56.58.102] (unknown [9.56.58.102])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 May 2019 14:30:36 +0000 (GMT)
Subject: Re: [PATCH v2 1/7] s390/cio: Update SCSW if it points to the end of
 the chain
To:     Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
References: <20190514234248.36203-1-farman@linux.ibm.com>
 <20190514234248.36203-2-farman@linux.ibm.com>
From:   Farhan Ali <alifm@linux.ibm.com>
Date:   Wed, 15 May 2019 10:30:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190514234248.36203-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051514-0004-0000-0000-0000150F0896
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011102; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203701; UDB=6.00631845; IPR=6.00984627;
 MB=3.00026905; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-15 14:30:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051514-0005-0000-0000-00008BAC336C
Message-Id: <978ed329-cc81-b08f-8d59-ae92350abc17@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150089
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 05/14/2019 07:42 PM, Eric Farman wrote:
> Per the POPs [1], when processing an interrupt the SCSW.CPA field of an
> IRB generally points to 8 bytes after the last CCW that was executed
> (there are exceptions, but this is the most common behavior).
> 
> In the case of an error, this points us to the first un-executed CCW
> in the chain.  But in the case of normal I/O, the address points beyond
> the end of the chain.  While the guest generally only cares about this
> when possibly restarting a channel program after error recovery, we
> should convert the address even in the good scenario so that we provide
> a consistent, valid, response upon I/O completion.
> 
> [1] Figure 16-6 in SA22-7832-11.  The footnotes in that table also state
> that this is true even if the resulting address is invalid or protected,
> but moving to the end of the guest chain should not be a surprise.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 384b3987eeb4..41f48b8790bc 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -870,7 +870,11 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>   	 */
>   	list_for_each_entry(chain, &cp->ccwchain_list, next) {
>   		ccw_head = (u32)(u64)chain->ch_ccw;
> -		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len)) {
> +		/*
> +		 * On successful execution, cpa points just beyond the end
> +		 * of the chain.
> +		 */
> +		if (is_cpa_within_range(cpa, ccw_head, chain->ch_len + 1)) {
>   			/*
>   			 * (cpa - ccw_head) is the offset value of the host
>   			 * physical ccw to its chain head.
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

