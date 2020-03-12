Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A182F182F20
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2020 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLL3L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Mar 2020 07:29:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLL3K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 07:29:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CBN302105024
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 07:29:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqm3s0fmf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 07:28:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 12 Mar 2020 10:17:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Mar 2020 10:17:22 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CAHLpa51314914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 10:17:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 254C54203F;
        Thu, 12 Mar 2020 10:17:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E44DC42041;
        Thu, 12 Mar 2020 10:17:14 +0000 (GMT)
Received: from funtu.home (unknown [9.145.73.108])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 10:17:14 +0000 (GMT)
Subject: Re: [PATCH] s390/zcrypt: Use scnprintf() for avoiding potential
 buffer overflow
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
References: <20200311090915.21059-1-tiwai@suse.de>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 12 Mar 2020 11:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311090915.21059-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20031210-0016-0000-0000-000002EFDD77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031210-0017-0000-0000-000033534AFA
Message-Id: <b098aca8-6a90-6b0d-408f-2f86a6e73032@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_03:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120062
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.03.20 10:09, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/s390/crypto/zcrypt_cex4.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
> index 9a9d02e19774..dea96d5b65fb 100644
> --- a/drivers/s390/crypto/zcrypt_cex4.c
> +++ b/drivers/s390/crypto/zcrypt_cex4.c
> @@ -128,16 +128,16 @@ static ssize_t cca_mkvps_show(struct device *dev,
>  		n = snprintf(buf, PAGE_SIZE, "AES NEW: - -\n");
>  
>  	if (ci.cur_mk_state >= '1' && ci.cur_mk_state <= '2')
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: %s 0x%016llx\n",
>  			      cao_state[ci.cur_mk_state - '1'], ci.cur_mkvp);
>  	else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES CUR: - -\n");
>  
>  	if (ci.old_mk_state >= '1' && ci.old_mk_state <= '2')
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: %s 0x%016llx\n",
>  			      cao_state[ci.old_mk_state - '1'], ci.old_mkvp);
>  	else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "AES OLD: - -\n");
>  
>  	return n;
>  }
> @@ -251,11 +251,11 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
>  		if (ci.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
>  			if (n > 0)
>  				buf[n++] = ' ';
> -			n += snprintf(buf + n, PAGE_SIZE - n,
> +			n += scnprintf(buf + n, PAGE_SIZE - n,
>  				      "%s", ep11_op_modes[i].mode_txt);
>  		}
>  	}
> -	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  
>  	return n;
>  }
> @@ -305,21 +305,21 @@ static ssize_t ep11_mkvps_show(struct device *dev,
>  			     cwk_state[di.cur_wk_state - '0']);
>  		bin2hex(buf + n, di.cur_wkvp, sizeof(di.cur_wkvp));
>  		n += 2 * sizeof(di.cur_wkvp);
> -		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  	} else
>  		n = snprintf(buf, PAGE_SIZE, "WK CUR: - -\n");
>  
>  	if (di.new_wk_state == '0') {
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s -\n",
>  			      nwk_state[di.new_wk_state - '0']);
>  	} else if (di.new_wk_state >= '1' && di.new_wk_state <= '2') {
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: %s 0x",
>  			      nwk_state[di.new_wk_state - '0']);
>  		bin2hex(buf + n, di.new_wkvp, sizeof(di.new_wkvp));
>  		n += 2 * sizeof(di.new_wkvp);
> -		n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  	} else
> -		n += snprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
> +		n += scnprintf(buf + n, PAGE_SIZE - n, "WK NEW: - -\n");
>  
>  	return n;
>  }
> @@ -346,11 +346,11 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
>  		if (di.op_mode & (1 << ep11_op_modes[i].mode_bit)) {
>  			if (n > 0)
>  				buf[n++] = ' ';
> -			n += snprintf(buf + n, PAGE_SIZE - n,
> +			n += scnprintf(buf + n, PAGE_SIZE - n,
>  				      "%s", ep11_op_modes[i].mode_txt);
>  		}
>  	}
> -	n += snprintf(buf + n, PAGE_SIZE - n, "\n");
> +	n += scnprintf(buf + n, PAGE_SIZE - n, "\n");
>  
>  	return n;
>  }

Thanks for this patch.

I will use this as a trigger point to rework all the snprintfs within the ap bus and zcrypt code
and replace them with scnprintf wherever the return code is used. Did not know that
there are issues with snprintf ... This article gives some background: https://lwn.net/Articles/69419/

The updates will go into the s390 subsystem and will be forwarded to the upstream kernel with the
next kernel merge window.

Harald Freudenberger

