Return-Path: <linux-s390+bounces-4059-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3C8D27AE
	for <lists+linux-s390@lfdr.de>; Wed, 29 May 2024 00:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240622885DD
	for <lists+linux-s390@lfdr.de>; Tue, 28 May 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20013D8BE;
	Tue, 28 May 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SbC2duol"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C513D29B
	for <linux-s390@vger.kernel.org>; Tue, 28 May 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933788; cv=none; b=LrJm7W/RMIGRuUOWHg2MyvK9iqpfopq1MtauaNshXw8EhbPFOfu5y4aynxXZDkQfHK3kzYlKKeOxnEh/waU+DUpoz0PXc+ZUC1Z5Q1t4qbWdD/rFAHFWxwiJF3CO59FIcJlL9ioBVeFpQC63dcJy7l7kN9PVW12+ZgUqYmYz5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933788; c=relaxed/simple;
	bh=6dR0TVFfyiSaynxrc8HqYHuyfp8lRjhMTghZIQUKmZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/pDGd21REVeIDlpWamhJXyYN5LTL2mjOQGUI1GwZGVlDY4Zuq9/FYAWdpicLjDZbzByJURnpGbrvM7EyFkksCABSgT5plrNmjDakrI4ckdsKf2ZlQSfSGfF2VFyIYkIMtTJNPgHU6QNsPED7cGhfbup8XvhrMlVAa19Lwwvs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SbC2duol; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e964acff1aso13939121fa.0
        for <linux-s390@vger.kernel.org>; Tue, 28 May 2024 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716933784; x=1717538584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ozLHkJmijyEcijsJIlg7rU3H7zvIY0vd9gob+uXPOsY=;
        b=SbC2duolOW0qbnc9HwlM6DVvpQFjY9hGl7Auu2aHWxrGqozx3EAUv49i6pZMUgC+RJ
         MEuT2lQW2lPUkojezPTrXGt8pACiob+8l8cjwtEBBtjSWK1u+5RA0hJIjqz4RPdHUzJh
         5aYdYMe5U/Kh+cyWX+gZ3MFT7RuMrhD2fTrcSBWRlS0m8E52/TCG+DGldpp9D7r9kdPm
         rIwFELgXGA+LB9islnRJvNwTIF1ZcKopHe7Luy2pCv6avS/nxoZBzc4wuWrYq1sveXcc
         xI0GPy/vc6i8lKZYGubRC5eiwI/XqdNu2DCghrFdUVF/6Fw3vY0bpSlNROx1C0JqRLDt
         5Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716933784; x=1717538584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozLHkJmijyEcijsJIlg7rU3H7zvIY0vd9gob+uXPOsY=;
        b=bE+wSCN0w+28ufi64inPHnAjXBU+Ep5exLEcUCY3v1karjtHnCJXEp5WO3WrU4S3YM
         UyTppzj4jomJ4dFB3or2Y/pHxwLwGTeOxhLDOUuBKSLA/e/1uM9KfbpxNHQYkUvQNp5K
         QZNcfTEqzeyBPWivteD0lbgn376n8zDEVRmDyAAuJRPA+NeXBAynyID1xoH6Z2CMWWej
         5gUe+eeKrz2PEY9n1LAwDnEImgZLESc03JNKtO84QTCplL4ajAtMmkQ4dppRPl7/Zz1v
         7pJNObaO2mxOjE5/qOtuwrJ1sHK3hc9Fhln1S6eQ41SMpz/V8L4GNLRkIznzpwCrnZJU
         HUFw==
X-Forwarded-Encrypted: i=1; AJvYcCVIBw65EyXztVGmt8uMjzEQcR7I3UM6dOklo0pMyVTaH9VmEtA2cvSoYBeuhCc6am42l9a9Ez91aG6qFHnIUl18JdwqKbsi8Ib6+g==
X-Gm-Message-State: AOJu0YwaScjFg5vfrhwSDWp291He0o0rDDECrAQA4fnGoh/s5xxaNTwt
	4zc1o1WXJ6K8Oh8BQnfoM9TMql/EY0TLEloVARB0ShPFAkyvQRBQXy88GTtSa88=
X-Google-Smtp-Source: AGHT+IFSlWFNVUOxV4lr95h/gJfRtfKsaiT4upArCCJB+M0+D4CCLz8QxF33KW+4hi3B8pAS8MMlpQ==
X-Received: by 2002:a2e:bc08:0:b0:2e9:570e:1cf with SMTP id 38308e7fff4ca-2e95b3089d9mr100629691fa.52.1716933784476;
        Tue, 28 May 2024 15:03:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb199sm6855027b3a.105.2024.05.28.15.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 15:03:04 -0700 (PDT)
Message-ID: <4c012b7d-52f9-469d-b272-bd93f3e73854@suse.com>
Date: Wed, 29 May 2024 07:32:58 +0930
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zlib: do not do unnecessary page copying for
 compression
To: dsterba@suse.cz, Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <0a24cc8a48821e8cf3bd01263b453c4cbc22d832.1716801849.git.wqu@suse.com>
 <08aca5cf-f259-4963-bb2a-356847317d94@linux.ibm.com>
 <a24ef846-95f9-413d-abfa-54b06281047a@gmx.com>
 <2db8bc9a-5ff0-40ec-92ba-29c90b6976c7@linux.ibm.com>
 <20240528214350.GI8631@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240528214350.GI8631@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/29 07:13, David Sterba 写道:
> On Tue, May 28, 2024 at 12:44:19PM +0200, Zaslonko Mikhail wrote:
>>> But I'm still wondering if we do not go 4 pages as buffer, how much
>>> performance penalty would there be?
>>>
>>> One of the objective is to prepare for the incoming sector perfect
>>> subpage compression support, thus I'm re-checking the existing
>>> compression code, preparing to change them to be subpage compatible.
>>>
>>> If we can simplify the behavior without too large performance penalty,
>>> can we consider just using one single page as buffer?
>>
>> Based on my earlier estimates, bigger buffer provided up to 60% performance for inflate and up to 30% for
>> deflate on s390 with dfltcc support.
>> I don't think giving it away for simplification would be a good idea.
> 
> 60% and 30% sound like significant gain, I agree this takes precedence
> over code simplification. Eventually the s390 optimized case can be
> moved to a separate function if the conditions are satisfied so it's not
> mixed with the page-by-page code.

Thanks a lot for the numbers, the number is indeed impressive.

I'll definitely leave the larger buffer support untouched.
And thankfully since S390 only supports 4K page size, we won't need to 
bother too much for that routine.

Thanks,
Qu

