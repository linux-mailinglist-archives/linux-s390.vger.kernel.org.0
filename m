Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29CF3F00B5
	for <lists+linux-s390@lfdr.de>; Wed, 18 Aug 2021 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhHRJjf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Aug 2021 05:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232577AbhHRJjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 05:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629279535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXkC/Zz8d42rLoVxJCKPmI4UarBPoIcxyNVz8r4Tnas=;
        b=GQTTB9fw4eHwpOAHbcy00YN+uwZRLfbLJLaao6avEnPvfMOGMna5Rn3pwXx+WoTgruPz/R
        wRDduIzVwp437agkPDpi1gM1l/IrIlJxI1mkekXLsEfBTap7JPugJWTN0G8MQx+FU7RsIU
        4dLom2bCSWy7EvHGqYYngG+rUwVHQuU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-c9sjigTuOvSlND_y_cmnDw-1; Wed, 18 Aug 2021 05:38:54 -0400
X-MC-Unique: c9sjigTuOvSlND_y_cmnDw-1
Received: by mail-ed1-f69.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so744581edt.9
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 02:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aXkC/Zz8d42rLoVxJCKPmI4UarBPoIcxyNVz8r4Tnas=;
        b=Paqex1rh5Hq4u/Xjpiv6a30DckQx6ZN0yf3nlKV6sCa+1Utpt+0+gsJ3WSEmu+9ytC
         iV4NAdgqs1ZsVhOMRQuVhGIfRjPOrH8MOJJqiOly401d15f/pLG+r/ua1s1112Wd4ERL
         q8keVp5nUgEYCUM06MYttCFSvuNb980B/0emo9Nr5+FfLSLAGVKrJA6RIkdI4+LLDXhs
         Dqv6yqJdGVp83RmV7dWuRv0KLBKpr+dX11UfuTi2nun/yQEGhMxpm8y4OLd+Rbzq8XC3
         J1rjgGvKTunooGATQGhF8b4LN/qYwdgQx2mI5qFyYwk57JGteM1GfmQ1esu/e3IIh4mP
         P8zg==
X-Gm-Message-State: AOAM532j0NGy/l60RZnQdMCv4n58CrjENNBdeFLOZPjy3e5NZYcRciSV
        RUnPHm6dsCY0qqWnbSeWGEgClBGL+vrWJnqcAeudTeFaRVx0JIhgS/CjNWXcLCCZ9ElXFSlfszA
        iKGbVs1hDxU9zAjhyCDVK4Q==
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr9048411ejw.317.1629279533293;
        Wed, 18 Aug 2021 02:38:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0UUAy4UP24eWYAGTr4ikI15BE5LDp4nxVM35nDL6yuIvm63328asMjLa+QJp/eiw1G7q9eQ==
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr9048388ejw.317.1629279533051;
        Wed, 18 Aug 2021 02:38:53 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id br16sm1796971ejb.34.2021.08.18.02.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:38:52 -0700 (PDT)
Subject: Re: [PATCH 1/2] sysctl: introduce new proc handler proc_dobool
From:   Thomas Huth <thuth@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-s390@vger.kernel.org, Jia He <hejianet@gmail.com>
References: <20210803105937.52052-1-thuth@redhat.com>
 <20210803105937.52052-2-thuth@redhat.com>
Message-ID: <5e359b28-6233-a97e-a30f-0a30fa516833@redhat.com>
Date:   Wed, 18 Aug 2021 11:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803105937.52052-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/08/2021 12.59, Thomas Huth wrote:
> From: Jia He <hejianet@gmail.com>
> 
> This is to let bool variable could be correctly displayed in
> big/little endian sysctl procfs. sizeof(bool) is arch dependent,
> proc_dobool should work in all arches.
> 
> Suggested-by: Pan Xinhui <xinhui@linux.vnet.ibm.com>
> Signed-off-by: Jia He <hejianet@gmail.com>
> [thuth: rebased the patch to the current kernel version]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/linux/sysctl.h |  2 ++
>   kernel/sysctl.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index d99ca99837de..1fa2b69c6fc3 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -48,6 +48,8 @@ typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
>   		size_t *lenp, loff_t *ppos);
>   
>   int proc_dostring(struct ctl_table *, int, void *, size_t *, loff_t *);
> +int proc_dobool(struct ctl_table *table, int write, void *buffer,
> +		size_t *lenp, loff_t *ppos);
>   int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
>   int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
>   int proc_dointvec_minmax(struct ctl_table *, int, void *, size_t *, loff_t *);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 272f4a272f8c..25e49b4d8049 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -536,6 +536,21 @@ static void proc_put_char(void **buf, size_t *size, char c)
>   	}
>   }
>   
> +static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> +				int *valp,
> +				int write, void *data)
> +{
> +	if (write) {
> +		*(bool *)valp = *lvalp;
> +	} else {
> +		int val = *(bool *)valp;
> +
> +		*lvalp = (unsigned long)val;
> +		*negp = false;
> +	}
> +	return 0;
> +}
> +
>   static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
>   				 int *valp,
>   				 int write, void *data)
> @@ -798,6 +813,26 @@ static int do_proc_douintvec(struct ctl_table *table, int write,
>   				   buffer, lenp, ppos, conv, data);
>   }
>   
> +/**
> + * proc_dobool - read/write a bool
> + * @table: the sysctl table
> + * @write: %TRUE if this is a write to the sysctl file
> + * @buffer: the user buffer
> + * @lenp: the size of the user buffer
> + * @ppos: file position
> + *
> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> + * values from/to the user buffer, treated as an ASCII string.
> + *
> + * Returns 0 on success.
> + */
> +int proc_dobool(struct ctl_table *table, int write, void *buffer,
> +		size_t *lenp, loff_t *ppos)
> +{
> +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
> +				do_proc_dobool_conv, NULL);
> +}
> +
>   /**
>    * proc_dointvec - read a vector of integers
>    * @table: the sysctl table
> @@ -1630,6 +1665,12 @@ int proc_dostring(struct ctl_table *table, int write,
>   	return -ENOSYS;
>   }
>   
> +int proc_dobool(struct ctl_table *table, int write,
> +		void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	return -ENOSYS;
> +}
> +
>   int proc_dointvec(struct ctl_table *table, int write,
>   		  void *buffer, size_t *lenp, loff_t *ppos)
>   {
> @@ -3425,6 +3466,7 @@ int __init sysctl_init(void)
>    * No sense putting this after each symbol definition, twice,
>    * exception granted :-)
>    */
> +EXPORT_SYMBOL(proc_dobool);
>   EXPORT_SYMBOL(proc_dointvec);
>   EXPORT_SYMBOL(proc_douintvec);
>   EXPORT_SYMBOL(proc_dointvec_jiffies);
> 

Friendly ping!

Luis, Kees, Iurii, could you please have a look and provide an Ack if this 
looks ok to you?

  Thanks,
   Thomas

